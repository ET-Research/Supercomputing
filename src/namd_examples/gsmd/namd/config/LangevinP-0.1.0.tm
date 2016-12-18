namespace eval ::namd {namespace export LangevinP}


#-------------------------------------------------------
# Add Langevin pressure control
# grid_params: a dictionary with the following keys:
#   flexible_cell - whether to decouple pressure control in each dimension
#   constant_area - whether to keep X-Y plane area constant
#   constant_ratio - whether to key box expansion ratio constant
#   group ("yes") - whether to use hydrogen-group based pseudo-molecular virial
#                   and kinetic energy. 
#   target (1.01325) - target pressure in bars
#   period (100) - Piston period (2 fs/step * 100 = 200 fs)
#                   Recommend 200 fs piston periold as suggested by 
#                   http://www.ks.uiuc.edu/Research/namd/2.10/ug/node37.html
#   decay (50) - piston oscillation decay time (2 fs/step * 50 = 100 fs)
#               Recommend 100 fs piston decay time as suggested by 
#               http://www.ks.uiuc.edu/Research/namd/2.10/ug/node37.html
# ------------------------------------------------------
proc ::namd::LangevinP {params} {
    set defaults [dict create \
        group    "yes" \
        target    1.01325 \
        period    100. \
        decay     50. \
    ]
    
    set p [dict merge $defaults $params]

    useGroupPressure      [dict get $p "group"] ;# needed for 2fs steps
    useFlexibleCell       [dict get $p "flexible_cell"]
    useConstantArea       [dict get $p "constant_area"]
    useConstantRatio      [dict get $p "constant_ratio"]

    langevinPiston        on
    langevinPistonTemp    [dict get $p "T"]
    langevinPistonTarget  [dict get $p "target"] ;#  bar -> 1 atm
    langevinPistonPeriod  [dict get $p "period"] ;# 
    langevinPistonDecay   [dict get $p "decay"]  ;# 1
}