(:
For each interview, report the forename of the person interviewed, the ID of the interviewer, and the highest
score they got on any of these items in their assessment: communication, enthusiasm, and collegiality. (If
there is a tie, report them all.)
:)

(:
for each interview in interviews
	let candidate := fn:doc('resume.xml')/resume[@rID = interview/@rID]
	return interview.sID, max assessment category score 
:)


declare variable $dataset0 external;
declare variable $dataset1 external;

<bestskills>{

for $interview in $dataset0//interview
	let $candidate := $dataset1//resume[@rID = $interview/@rID]
	return
		let $comm := $interview/assessment/communication
		let $ent := $interview/assessment/enthusiasm
		let $col := $interview/assessment/collegiality
			
		let $assessments := <assessments>
			{$comm}
			{$ent } 
			{$col }
		</assessments>
		
		let $maxScore := $assessments/max(*)
		
		for $assessment in $assessments/*
			return
			
				if (data($assessment) = $maxScore) 
				then (
					<best resume="{$candidate/@rID}" position="{$interview/@pID}">{
						$assessment
					}</best>
				) 
				else ()

}
</bestskills>
