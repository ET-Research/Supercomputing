namespace eval ::namd {namespace export outputFrequency}


#---------------------------------------------------
# Apply Langevin temperature control
# input dictionary keys (default values):
#   T - temperature
#   isRestart - "true"/"false"
#   damping (1) - Langevin damping coefficient
#---------------------------------------------------
proc ::namd::LangevinT {params} {
    set defaults [dict create \
        damping 1
    ]
    
    set p [dict merge $defaults $params]

    if {[dict get $p "isRestart"] == false} {
        temperature [dict get $p "T"]
    } else {}
    
    langevin            on              
    langevinTemp        [dict get $p "T"]
    langevinDamping     [dict get $p "damping"]
}
