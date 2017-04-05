declare variable $dataset0 external;
declare variable $dataset1 external;



<histogram>
{
for $skill in distinct-values($dataset0//reqSkill/@what)
	return <skill name="{$skill}">{
		for $l in 1 to 5
                let $count := count($dataset1//skill[@what = $skill and @level = $l])

                return <count level="{$l}" n="{$count}"/>
	}</skill>

}
</histogram>

