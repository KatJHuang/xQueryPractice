declare variable $dataset0 external;

<dbjobs>
{
for $p in $dataset0/postings/posting
where $p/reqSkill[@what='SQL' and @level='5']
return $p
}
</dbjobs>
