-- Ak existuju kuzelníci ktorí maju pozitivnu synergiu s elementom vacsiu ako 50 tak vypis bytosti s pozitivnou synergiou vacsou ako 50

Select * From
(Select * from MAGICAL_BEING where
exists (
Select * from POSITIVE_SYNERGY Where "limit" > 50) ) magical_being
inner join ( Select * from POSITIVE_SYNERGY Where "limit" > 50) positive
ON  positive.ID_MAGICAL_BEING = magical_being.ID_MAGICAL_BEING;