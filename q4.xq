(:
For each interview, report the forename of the person interviewed, the ID of the interviewer, and the highest
score they got on any of these items in their assessment: communication, enthusiasm, and collegiality. (If
there is a tie, report them all.)
:)

(:
for each interview in interviews
	let candidate := fn:doc('resume.xml')/resume[@rID = interview/@rID]
	return interview.sID, max candidate score 
:)

for $interview in fn:doc('interview.xml')//interview
	let $candidate := fn:doc('resume.xml')/resume[@rID = interview/@rID]
	let $posting := fn:doc('posting.xml')/posting[@pID = interview/@pID]
	return
	<best resume="{$candidate/@rID}" position="{$posting/@position}">
	{
		
	}
	</best>

	