namespace eval ::namd {namespace export usePME}


#---------------------------------------------------
# Apply PME
# Input dictionary keys
#   spacing - PME grid spacing 
#---------------------------------------------------
proc ::namd::usePME {params} {
    set defaults [dict create \
        spacing 1.0 \
    ]
    assertDictKeyLegal $defaults $params "::namd::usePME"
    set p [dict merge $defaults $params]
    PME yes
    PMEGridSpacing [dict get $p spacing]
}
