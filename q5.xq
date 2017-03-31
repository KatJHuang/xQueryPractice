<histogram>{
	
for $skill in fn:doc('posting.xml')//reqSkill
	return <skill name="{string($skill/@what)}">{
		for $l in 1 to 5
                let $count := count(fn:doc('resume.xml')//skill[@what = $skill/@what and @level = $l])

                return <count level="{$l}" n="{count($resumes)}"/>
	}</skill>
}</histogram>

(:==============================:)(:==============================:)(:==============================:)
return fn:distinct-values($skills)