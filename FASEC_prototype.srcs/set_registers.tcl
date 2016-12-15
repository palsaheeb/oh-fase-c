# this scripts queries some variables and put them
# in a VHDL file for use during synthesis
# start manually as follows:
# cd /home/pieter/Development/projects/FIDS/FASEC_prototype; source FASEC_prototype.srcs/set_registers.tcl; reset_run synth_1; launch_runs synth_1 -to_step write_bitstream -jobs 2
# launch_runs synth_1 -jobs 2

# xilinc tcl info:
# each class can have many properties, to list them:
# llength [list_property -class bd_cell]
# list_property [get_bd_cells fasec*]

# settings
set filefilter *top_mod*
set git {/usr/bin/git}
set backupext .old

puts [pwd]
set projd [get_property DIRECTORY [current_project]]
puts $projd
set bdd [get_files -of_objects [get_filesets sources_1] *bd]
# using get_files avoids having to know the IP version etc.
set topfile [get_files -of_objects [get_filesets sources_1] $filefilter]

cd $projd
set dateCode [format %08X [clock seconds]]
set gitCode [string range [exec $git log --format=%H -n 1] 0 7]

if [file exists $topfile$backupext]==0 {
    # copy needed because we'll modify the DEADBEE. strings
    file copy -force $topfile $topfile$backupext
}
set fr [open $topfile$backupext r]
set fw [open $topfile r+]
set cont [regsub -all {DEADBEE1} [read $fr] $dateCode]
set cont [regsub -all {DEADBEE2} $cont $gitCode]
seek $fw 0; # go to beginning of file to overwrite
puts $fw $cont
close $fw
close $fr

puts done
