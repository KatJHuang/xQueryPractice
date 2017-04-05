declare variable $dataset0 external;


<qualified>{
for $r in $dataset0/resumes/resume
where $r/skills[count(skill)>3]
return 
	<candidate rid="{$r/@rID}" numskills="{count($r/skills/skill)}" citizenzhip="{$r/identification/citizenship}">
		<name> {data($r/identification/name/forename)} </name>
	</candidate>
}</qualified>
