-- vytvoření alespoň dvou netriviálních uložených procedur vč. jejich předvedení, ve kterých se musí (dohromady)
-- vyskytovat alespoň jednou kurzor, ošetření výjimek a použití proměnné s datovým typem odkazujícím se na řádek či
-- typ sloupce tabulky (table_name.column_name%TYPE nebo table_name%ROWTYPE),

-- Nájde všetky kúzla s typom spell_type a spočíta priemer sily kúziel s týmto typom.
CREATE OR REPLACE PROCEDURE spell_avg_strength (spell_type IN VARCHAR)
AS
    BEGIN
        DECLARE CURSOR cursor_curse IS
            SELECT SPELL."strength", SPELL."type"
            FROM  SPELL;
        rec_strength SPELL."strength"%TYPE;
        rec_type SPELL."type"%TYPE;
        suma NUMBER;
        counterr NUMBER;
        biggest NUMBER;
        result NUMBER;
        BEGIN
            suma:=0;
            counterr:=0;
            biggest:=0;
            OPEN cursor_curse;
            LOOP
                FETCH cursor_curse INTO rec_strength, rec_type;
                EXIT WHEN cursor_curse%NOTFOUND;
                if rec_type=spell_type THEN
                        suma:=suma+rec_strength;
                        counterr:=counterr+1;
                        if biggest < rec_strength THEN
                            biggest := rec_strength;
                        end if;
                END IF;
            END LOOP;
            result:=(suma/counterr);
            CLOSE cursor_curse;
            dbms_output.put_line('Celkovo kuziel ' || counterr || ' najvyššia hodnota ' || biggest || ' priemer ' ||  result || '');
            EXCEPTION
            WHEN ZERO_DIVIDE THEN
                    dbms_output.put_line('Nenaslo sa ziadne kuzlo s danym typom!');
            WHEN OTHERS THEN
                    raise_application_error(-20420, 'Nastala chyba pri vyhladani kuziel s danym typom!');
        END;
    END;
/

-- vypočíta kolko % kuziel má hlavný element s farbou mágie magic_color
CREATE OR REPLACE PROCEDURE get_percentage_of (in_element IN VARCHAR)
AS
    BEGIN
        DECLARE CURSOR cursor_spell IS
            SELECT SPELL."mainElement"
            FROM  SPELL;
        rec_spell_element SPELL."mainElement"%TYPE;
        counter_all NUMBER;
        counter_elem NUMBER;
        result NUMBER;
        BEGIN
            counter_elem :=0;
            counter_all:=0;
            result:=0;
            OPEN cursor_spell;
            LOOP
                FETCH cursor_spell INTO rec_spell_element;
                EXIT WHEN cursor_spell%NOTFOUND;
                    IF rec_spell_element=in_element THEN
                        counter_elem:=counter_elem+1;
                    END IF;
                counter_all:=counter_all+1;
            END LOOP;
            result:=counter_elem/(counter_all/100);
            CLOSE cursor_spell;
            dbms_output.put_line('Celkovo kuziel ' || counter_all || ' počet hladanych kuziel ' || counter_elem || ' počet percent ' ||  result || '');
            EXCEPTION
            WHEN ZERO_DIVIDE THEN
                    dbms_output.put_line('Nenaslo sa ziadne kuzlo s danym typom!');
            WHEN OTHERS THEN
                    raise_application_error(-20420, 'Nastala chyba pri vyhladani kuziel!');
        END;
    END;
/

begin
    SPELL_AVG_STRENGTH('CURSE');
end;
/

begin
    GET_PERCENTAGE_OF('elem88714');
end;
