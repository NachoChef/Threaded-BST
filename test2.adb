WITH gstack;
WITH ada.text_io; USE ada.text_io;
PACKAGE BODY binarysearchtree IS
    count : integer := 0;
    root : binarysearchtreepoint;

    PROCEDURE init IS
    BEGIN
        root := NULL;
    END;

    PROCEDURE insertbinarysearchtree (
            custname  : IN     string10;
            custphone : IN     string10) IS
        p : binarysearchtreepoint;
        q : binarysearchtreepoint;
    BEGIN
        count:=count+1;
        IF root = NULL THEN
            allocatenode(q, custname, custphone);
            root := q;
        ELSE
            p := root;
            LOOP
                IF custname < p.info.name THEN
                    IF p.llink /= NULL THEN
                        p := p.llink;
                    ELSE
                        allocatenode(q, custname, custphone);
                        insertnode(p, q, custname, custphone);
                        EXIT;                    END IF;
                ELSIF custname > p.info.name THEN
                    IF p.rlink /= NULL THEN
                        p := p.rlink;
                    ELSE
                        allocatenode(q, custname, custphone);
                        insertnode(p, q, custname, custphone);
                        EXIT;
                    END IF;
                ELSE
                    EXIT;
                END IF;
            END LOOP;
        END IF;
    END insertbinarysearchtree;

    PROCEDURE allocatenode(q : OUT binarysearchtreepoint; namekey: IN string10; numkey : IN string10) IS
    BEGIN
        q := NEW node;
        q.info.name := namekey;
        q.info.phonenumber := numkey;
        q.llink := NULL;
        q.rlink := NULL;
        q.rtag := false;
        q.ltag := false;
    END;

    PROCEDURE insertnode(p : IN OUT binarysearchtreepoint; q : IN OUT binarysearchtreepoint; namekey : IN string10; numkey : IN string10) IS
    BEGIN
        IF namekey < p.info.name THEN
            p.llink := q;
        ELSE
            p.rlink := q;
        END IF;
    END;

    PROCEDURE findcustomeriterative (
            custname  : IN     string10;
            customerpoint :    OUT binarysearchtreepoint) IS
        p    : binarysearchtreepoint := root;
        temp : integer               := count;
    BEGIN
        LOOP
            IF temp = 0 THEN
                p:=root;
                EXIT;
            END IF;

            IF p /= NULL THEN
                IF p.info.name = custname THEN
                    customerpoint := p;
                    EXIT;
                ELSIF p.info.name <= custname THEN
                    p := p.rlink;
                ELSE
                    p := p.llink;
                END IF;
            ELSE
                EXIT;
            END IF;
            temp:=temp-1;
        END LOOP;
        customerpoint:=p;
    END findcustomeriterative;

    PROCEDURE findcustomerrecursive(custname : IN string10; custpoint : OUT binarysearchtreepoint) IS
    BEGIN
        findcustomerrecursive(root, custname, custpoint); --overload for first run.
    END;

    PROCEDURE findcustomerrecursive (startnode : IN binarysearchtreepoint;
            customername  : IN     string10;
            customerpoint :    OUT binarysearchtreepoint) IS
        p : binarysearchtreepoint;
    BEGIN
        IF startnode /= NULL THEN
            p := startnode;
            IF p.info.name = customername THEN
                customerpoint := p;

            ELSIF p.info.name <= customername THEN
                findcustomerrecursive(p.rlink, customername,customerpoint);

            ELSE
                findcustomerrecursive(p.llink, customername,customerpoint);

            END IF;
        ELSE
            customerpoint := p;
        END IF;

    END findcustomerrecursive;

    FUNCTION inordersuccessor (
            treepoint : IN     binarysearchtreepoint)
            RETURN binarysearchtreepoint IS
        p : binarysearchtreepoint;
        q : binarysearchtreepoint;
    BEGIN
        p:=treepoint;
        q := p.rlink;
        IF p.rtag = false THEN
            p:=q;
        ELSE
            WHILE q.ltag = true LOOP
                q := q.llink;
            END LOOP;
            p:=q;
        END IF;

        RETURN p;
    END inordersuccessor;

    FUNCTION customername (
            treepoint : IN     binarysearchtreepoint)
            RETURN string10 IS
    BEGIN
        IF treepoint /= NULL THEN
            RETURN treepoint.info.name;
        ELSE
            RETURN "null      ";
        END IF;
    END customername;

    FUNCTION customerphone (
            treepoint : IN     binarysearchtreepoint)
            RETURN string10 IS
    BEGIN
        RETURN treepoint.info.phonenumber;
    END customerphone;

    PROCEDURE inordertraversal(startnode : IN binarysearchtreepoint) IS
        PACKAGE node_stack IS NEW gstack(count, binarysearchtreepoint);
        USE node_stack;
        p : binarysearchtreepoint;
        x : binarysearchtreepoint;
    BEGIN
        p := startnode;
        LOOP
            IF p /= NULL THEN
                push(p);
                p := p.llink;
            ELSE
                IF empty = 1 THEN
                    EXIT;
                ELSE
                    pop(x);
                    put_line(string(x.info.name) & string(x.info.phonenumber));
                    p := x.rlink;
                END IF;
            END IF;
        END LOOP;
    END;

END binarysearchtree;