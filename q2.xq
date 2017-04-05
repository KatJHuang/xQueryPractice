(:let $postingReq := fn:doc('posting.xml')//reqSkill/(@level * @importance)

return max($postingReq) :)

declare variable $dataset0 external;

<important>{
for $skill in distinct-values($dataset0//reqSkill/@what)
	return 
		let $match := $dataset0//reqSkill[@what = $skill]
		let $maxVal := max($match/(@level * @importance))
		for $posting in $dataset0//posting
			where $posting/reqSkill[@what = $skill]/(@level * @importance) = $maxVal
			return $posting
			
}</important>

