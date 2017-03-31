for $posting in fn:doc('posting.xml')//posting
return xs:integer($posting/reqSkill/@level) * xs:integer($posting/reqSkill/@level)