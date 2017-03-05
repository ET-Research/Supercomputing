source config/packages.tm

######################################################
# Author: Steven(Yuhang) Wang
# License: CC BY 4.0 (creativecommons.org/licenses/by/4.0)
# Date:   03/04/2017
######################################################

set stage     2
set pre       [expr $stage - 1]
set isRestart [expr $stage > 1 ? true : false]
exec mkdir -p   "../output/md${stage}"

set temperature    310
set save_freq      5000
set md_steps       10000000

::namd::IO [dict create \
        first_time_step [::namd::lastTimeStep "../output/md${pre}/md${pre}.restart.xsc"] \
        structure       "../system/system.psf" \
        coordinates     "../system/system.pdb" \
        output_prefix   "../output/md${stage}/md${stage}" \
        input_prefix    "../output/md${pre}/md${pre}.restart" \
        isRestart       $isRestart \
    ]

::namd::forceField [list \
      "../forcefield/par_all36_prot.prm" \
      "../forcefield/par_all36_lipid.prm" \
      "../forcefield/par_all36_carb.prm" \
      "../forcefield/par_all36_cgenff.prm" \
      "../forcefield/toppar_all36_prot_arg0.str" \
      "../forcefield/toppar_water_ions.str" \
    ]

::namd::usePBC [dict create \
    size           {161.0 161.0 110.0} \
    center         {0 0 0} \
    isRestart      $isRestart \
]

::namd::interaction [dict create \
        cutoff         12.0 \
    ]

::namd::outputFrequency [dict create \
      dcd      $save_freq \
      restart  $save_freq \
      xst      $save_freq \
      energy   $save_freq \
      pressure $save_freq \
    ]

::namd::integrator [dict create \
        time_step        2.0 \
    ]
    
::namd::usePME [dict create spacing 1.0]

::namd::LangevinT [dict create \
        T         $temperature \
        isRestart $isRestart \
    ]

::namd::LangevinP [dict create \
        flexible_cell  yes \
        constant_area  no  \
        constant_ratio yes \
        T              $temperature \
    ]

::namd::harmonicRestraint [dict create \
    ref   "../restraint/ss.pdb" \
    label "../restraint/ss.pdb" \
    column B \
    scaling 1.0 \
]

# add external e-field (-300 mV)
::namd::elecField [dict create \
        vector {0 0 -6.92} \
        normalized yes \
    ]

margin 5
run    $md_steps 
