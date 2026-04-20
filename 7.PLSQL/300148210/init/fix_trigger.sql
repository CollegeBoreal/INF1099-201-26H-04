CREATE OR REPLACE FUNCTION log_action()
RETURNS trigger AS $$
BEGIN
    INSERT INTO logs(action)
    VALUES (TG_OP || ' sur ' || TG_TABLE_NAME || ' (id: ' || COALESCE(NEW.id::text, OLD.id::text) || ')');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;