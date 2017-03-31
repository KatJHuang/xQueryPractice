<histogram>{
for $skill in distinct-values(fn:doc('posting.xml')//reqSkill/@what)
	return <skill name="{$skill}">{
		for $l in 1 to 5
                let $count := count(fn:doc('resume.xml')//skill[@what = $skill and @level = $l])

                return <count level="{$l}" n="{$count}"/>
	}</skill>

}</histogram>
