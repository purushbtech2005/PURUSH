set val(chan)           Channel/WirelessChannel    ;# channel type
set val(prop)           Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)          Phy/WirelessPhy            ;# network interface type
set val(mac)            Mac/802_11                 ;# MAC type
set val(ifq)            Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)             LL                         ;# link layer type
set val(ant)            Antenna/OmniAntenna        ;# antenna model
set val(ifqlen)         1000                         ;# max packet in ifq
set val(nn)             50                          ;# number of mobilenodes
set val(rp)             AODV                       ;# routing protocol
set val(energymodel)    EnergyModel		   ;# Energy Model
set val(initialenergy)  100			   ;# value
set val(stop) 		100

# ======================================================================
# Main Program
# ======================================================================


# Initialize Global Variables
#
set ns		[new Simulator]
set tracefile   [open out.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile 1000 500

# set up topography object
set topo       [new Topography]

$topo load_flatgrid 1000 500

# Create God
create-god $val(nn)

set chan [new $val(chan)];

# configure node
$ns node-config -adhocRouting $val(rp) \
                -llType $val(ll) \
                -macType $val(mac) \
                -ifqType $val(ifq) \
                -ifqLen $val(ifqlen) \
                -antType $val(ant) \
                -propType $val(prop) \
                -phyType $val(netif) \
                -channel $chan \
                -topoInstance $topo \
                -agentTrace    ON \
                -routerTrace   ON \
                -macTrace      ON \
                -movementTrace OFF \
		-energyModel $val(energymodel) \
		-initialEnergy $val(initialenergy) \
		-rxPower 35.28e-3 \
		-txPower 31.32e-3 \
		-idlePower 712e-6 \
		-sleepPower 144e-9	

for {set i 0} {$i < $val(nn) } { incr i } {
	set node_($i) [$ns node]
}

source cbr
source location

#Define a 'finish' procedure
proc finish {} {
	global tracefile namfile
	#Close the output files
	close $tracefile
	close $namfile
	#Execute nam on the trace file
        exec nam out.nam &
        exit 0
}

#set nodes initial size
for { set i 0 } { $i < $val(nn) } { incr i } {
$ns initial_node_pos $node_($i) 30
}

# Telling nodes when the simulation ends
for {set i 0} {$i < $val(nn) } { incr i } {
$ns at $val(stop) "$node_($i) reset";
}

#Call the finish procedure after 20 seconds simulation time
$ns at $val(stop) "finish"

#Run the simulation
$ns run
