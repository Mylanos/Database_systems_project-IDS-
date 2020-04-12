-- Ktorý kuzelnici vlastnili svitok ?  Vypiste nazov kuzelnika a nazov svitku
Select scroll."Name" , magic_being."Name" From
( Select * From SCROLL ) scroll
inner join
( Select * From MAGICAL_BEING) magic_being
on scroll.ID_MAGICAL_BEING  = magic_being.ID_MAGICAL_BEING ;


-- Ktoré kúzla má hlavný element farbu Indigo ? Vypiste názov kúzla a názov elementu
Select spells."spellName" , elements."elementName" from
( Select * from SPELL ) spells
inner join
( Select * From ELEMENT where "colorMagic" = 'Indigo' ) elements
on spells."mainElement" = elements."idElement";

