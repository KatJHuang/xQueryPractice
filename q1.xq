<dbjobs>
{
for $p in fn:doc('posting.xml')/postings/posting
where $p/reqSkill[@what='SQL' and @level='5']
return $p
}
</dbjobs>
