# Copyright (C) 2011 Nippon Telegraph and Telephone Corporation.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""
An OpenFlow 1.0 L2 learning switch implementation.
"""

import logging
import struct

from ryu.base import app_manager
from ryu.controller import mac_to_port
from ryu.controller import ofp_event
from ryu.controller.handler import MAIN_DISPATCHER
from ryu.controller.handler import set_ev_cls
from ryu.ofproto import ofproto_v1_0
from ryu.lib.mac import haddr_to_bin
from ryu.lib.packet import packet
from ryu.lib.packet import ethernet


class HWP(app_manager.RyuApp):
    OFP_VERSIONS = [ofproto_v1_0.OFP_VERSION]

    def __init__(self, *args, **kwargs):
        super(HWP, self).__init__(*args, **kwargs)
        self.mac_to_port = {}

    def add_flow(self, datapath, in_port, dst, actions):
        ofproto = datapath.ofproto

        match = datapath.ofproto_parser.OFPMatch(
            in_port=in_port, dl_dst=haddr_to_bin(dst))

        mod = datapath.ofproto_parser.OFPFlowMod(
            datapath=datapath, match=match, cookie=0,
            command=ofproto.OFPFC_ADD, idle_timeout=0, hard_timeout=0,
            priority=ofproto.OFP_DEFAULT_PRIORITY,
            flags=ofproto.OFPFF_SEND_FLOW_REM, actions=actions)
        datapath.send_msg(mod)

    @set_ev_cls(ofp_event.EventOFPPacketIn, MAIN_DISPATCHER)
    def _packet_in_handler(self, ev):
	msg = ev.msg 						# PACKET_IN-Struktur in msg laden
	datapath = msg.datapath 				# Datapath aus msg entnehmen
	ofproto = datapath.ofproto 				# OpenFlow-Protokoll-Version
	
	paket = packet.Packet(msg.data) 			# enthaelt die MAC- und IP-Adresse von Quelle und Ziel
	eth = paket.get_protocols(ethernet.ethernet)[0] 	# MAC-Adressen der Quelle und des Ziels extrahieren

	mac_ziel = eth.dst  					# Ziel-MAC-Adresse
	mac_quelle = eth.src					# Quell-MAC-Adresse

	dpid = datapath.id 					# ID des Switches
	
	self.mac_to_port.setdefault(dpid, {})

        self.logger.info("Switch:%s MAC-Source:%s MAC-Destination:%s Switchport:%s", dpid, mac_quelle, mac_ziel, msg.in_port) 

	self.mac_to_port[dpid][mac_quelle] = msg.in_port	# Quell-MAC-Adresse in Dictionary speichern

	if mac_ziel in self.mac_to_port[dpid]: 			# Existiert die Ziel-MAC-Adresse im Dictionary ?
	    out_port = self.mac_to_port[dpid][mac_ziel] 	# Befehl "Sende an Ziel-MAC-Adresse" vormerken
	else:
	    out_port = ofproto.OFPP_FLOOD 			# andernfalls "OFPP_FLOOD" vormerken ("an alle senden")

	actions = [datapath.ofproto_parser.OFPActionOutput(out_port)] # actions mit vorgemerkten Befehl befuellen

	data = None
	if msg.buffer_id == ofproto.OFP_NO_BUFFER:
	    data = msg.data

	out = datapath.ofproto_parser.OFPPacketOut(		# Alle Informationen fuer Versand in Objekt packen
		 datapath=datapath				
	       	,buffer_id=msg.buffer_id
		,in_port=msg.in_port
		,actions=actions
		,data=data)

	if out_port != ofproto.OFPP_FLOOD: 			# existiert noch kein Flow-Eintrag fuer diesen Pfad ?
		self.add_flow(					# Flow-Eintrag erzeugen
		       	 datapath
			,msg.in_port
			,mac_ziel 
			,actions) 

	datapath.send_msg(out)					# Switch anweisen Paket zu senden

    @set_ev_cls(ofp_event.EventOFPPortStatus, MAIN_DISPATCHER)
    def _port_status_handler(self, ev):
        msg = ev.msg
        reason = msg.reason
        port_no = msg.desc.port_no

        ofproto = msg.datapath.ofproto
        if reason == ofproto.OFPPR_ADD:
            self.logger.info("port added %s", port_no)
        elif reason == ofproto.OFPPR_DELETE:
            self.logger.info("port deleted %s", port_no)
        elif reason == ofproto.OFPPR_MODIFY:
            self.logger.info("port modified %s", port_no)
        else:
            self.logger.info("Illeagal port state %s %s", port_no, reason)
