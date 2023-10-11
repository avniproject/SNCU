### Total SAM Children (non-exited and non-voided)

**code:**
```
'use strict';
({params, imports}) => {
    const isUndernourished = (enrolment) => {
        const encounter = enrolment.lastFulfilledEncounter('Child Followup');
        if(_.isNil(encounter)) return false;

       const obs = encounter.findObservation("Nutritional status of child");
       return (!_.isNil(obs) && _.isEqual(obs.getValueWrapper().getValue(), "SAM"));
    };

    return params.db.objects('Individual')
        .filtered(`voided = false and SUBQUERY(enrolments, $enrolment, $enrolment.program.name = 'Child' and $enrolment.programExitDateTime = null and $enrolment.voided = false and SUBQUERY($enrolment.encounters, $encounter, $encounter.encounterType.name = 'Child Followup' and $encounter.voided = false).@count > 0).@count > 0`)
        .filter((individual) =>  _.some(individual.enrolments, enrolment => enrolment.program.name === 'Child' && _.isNil(enrolment.programExitDateTime) && !enrolment.voided && isUndernourished(enrolment)))
};
```

### Total MAM Children (non-exited, non-voided and > 6 months)

**code:**
```
'use strict';
({params, imports}) => {
    const isUndernourished = (enrolment) => {
        const encounter = enrolment.lastFulfilledEncounter('Child Followup');
        if(_.isNil(encounter)) return false;

       const obs = encounter.findObservation("Nutritional status of child");
       return (!_.isNil(obs) && _.isEqual(obs.getValueWrapper().getValue(), "MAM"));
    };

    return params.db.objects('Individual')
        .filtered(`voided = false and SUBQUERY(enrolments, $enrolment, $enrolment.program.name = 'Child' and $enrolment.programExitDateTime = null and $enrolment.voided = false and SUBQUERY($enrolment.encounters, $encounter, $encounter.encounterType.name = 'Child Followup' and $encounter.voided = false).@count > 0).@count > 0`)
        .filter((individual) => individual.getAgeInMonths() > 6 && _.some(individual.enrolments, enrolment => enrolment.program.name === 'Child' && _.isNil(enrolment.programExitDateTime) && !enrolment.voided && isUndernourished(enrolment)))
};
```

### Low birth weight children (Includes non exited and non voided children)

**code:**
```
'use strict';
({params, imports}) => {
    const isLowBirthWeight = (enrolment) => {
        const obs = enrolment.findObservation('Birth Weight');
        return obs ? obs.getReadableValue() <= 2 : false;
    };
    return params.db.objects('Individual')
        .filtered(`voided = false and SUBQUERY(enrolments, $enrolment, $enrolment.program.name = 'Child' and $enrolment.programExitDateTime = null and $enrolment.voided = false).@count > 0`)
        .filter((individual) => _.some(individual.enrolments, enrolment => enrolment.program.name === 'Child' && _.isNil(enrolment.programExitDateTime) && !enrolment.voided && isLowBirthWeight(enrolment)))
};
```

### Children who migrated permanently (Includes exited and non voided children)

**code:**
```
'use strict';
({params, imports}) => {
   const moment = imports.moment;

   const isChildMigrated = (enrolment) => {
      const exitObservation = enrolment.findExitObservation('29238876-fbd8-4f39-b749-edb66024e25e');
      if(!_.isNil(exitObservation) && _.isEqual(exitObservation.getValueWrapper().getValue(), "edc26b08-3b8c-42f1-bc45-77b4649b3d86"))
        return true;

      const encounters = enrolment.getEncounters(false);
      const sortedEncounters = _.sortBy(encounters, (encounter) => {
      return _.isNil(encounter.cancelDateTime)? moment().diff(encounter.encounterDateTime) :
      moment().diff(encounter.cancelDateTime)});
      const latestEncounter = _.head(sortedEncounters);
      if(_.isNil(latestEncounter)) return false;

      const cancelObservation = latestEncounter.findCancelEncounterObservation('0066a0f7-c087-40f4-ae44-a3e931967767');
      if(_.isNil(cancelObservation)) return false;
      return _.isEqual(cancelObservation.getValueWrapper().getValue(), "edc26b08-3b8c-42f1-bc45-77b4649b3d86")
    };

return params.db.objects('Individual')
        .filtered(`voided = false`)
        .filter(individual => _.some(individual.enrolments, enrolment => enrolment.program.name === 'Child' && isChildMigrated(enrolment)));
};
```