-- vytvoření alespoň dvou netriviálních uložených procedur vč. jejich předvedení, ve kterých se musí (dohromady)
-- vyskytovat alespoň jednou kurzor, ošetření výjimek a použití proměnné s datovým typem odkazujícím se na řádek či
-- typ sloupce tabulky (table_name.column_name%TYPE nebo table_name%ROWTYPE),
CREATE OR REPLACE PROCEDURE curse_avg_duration (id_spell CHARACTER VARYING(100))
AS
BEGIN
    DECLARE CURSOR cursor_curse is
    SELECT *
    FROM  SPELL S,  CURSED_BEING C
    WHERE S."idSpell" = C."idSpell";
        id_spell SPELL."idSpell"%TYPE;
        BEGIN

    END;
END;

/*CREATE OR REPLACE PROCEDURE customer_ticket_avg_cost (id_customer_arg NUMBER) AS
  BEGIN
    DECLARE CURSOR cursor_cost is
    SELECT C.id, C.first_name, C.last_name, T.cost
    FROM  customers C,  reservations R, tickets T
    WHERE C.id = id_customer_arg AND C.id = R.created_by AND R.id = T.reservation;
			id_customer customers.id%TYPE;
			first_name customers.first_name%TYPE;
			last_name customers.last_name%TYPE;
			cost tickets.cost%TYPE;
			total_cost tickets.cost%TYPE;
			avg_cost tickets.cost%TYPE;
			num_tickets NUMBER;
			BEGIN
				num_tickets := 0;
				total_cost := 0;
				OPEN cursor_cost;
				LOOP
					FETCH cursor_cost INTO id_customer, first_name, last_name, cost;
					EXIT WHEN cursor_cost%NOTFOUND;
					num_tickets:=num_tickets+1;
					total_cost := total_cost + cost;
				END LOOP;
				CLOSE cursor_cost;
				avg_cost := total_cost / num_tickets;
				DBMS_OUTPUT.put_line('Customer ' || id_customer || ' name : ' || first_name || ' ' || last_name || ' avg_cost : ' || avg_cost);
				EXCEPTION WHEN ZERO_DIVIDE THEN
					BEGIN
					DBMS_OUTPUT.put_line('Customer with ID: ' || id_customer_arg || ' does not have reservation in database.');
				END;
			END;
	END;*/