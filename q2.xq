(:let $postingReq := fn:doc('posting.xml')//reqSkill/(@level * @importance)

return max($postingReq) :)

for $skill in distinct-values(fn:doc('posting.xml')//reqSkill/@what)
	return 
		let $match := fn:doc('posting.xml')//reqSkill[@what = $skill]
		let $maxVal := max($match/(@level * @importance))
		for $posting in fn:doc('posting.xml')//posting
			where $posting/reqSkill[@what = $skill]/(@level * @importance) = $maxVal
			return $posting
			


