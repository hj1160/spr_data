create sequence seq_board;

DROP TABLE t_member;


-- ȸ�� ���̺� ����
CREATE TABLE t_member(
    id VARCHAR2(20) primary key,
    pwd VARCHAR2(10),
    name VARCHAR2(50),
    email VARCHAR2(50),
    joinDate DATE DEFAULT SYSDATE
);

--ȸ�� ���� �߰�
INSERT INTO t_member
VALUES('hong', '1212', 'ȫ�浿', 'hong@gmail.com', sysdate);

INSERT INTO t_member
VALUES('lee', '1212', '�̼���', 'lee@test.com', sysdate);

INSERT INTO t_member
VALUES('kim', '1212', '������', 'kim@jweb.com', sysdate);
COMMIT;

SELECT * FROM t_member;



create table tbl_board(
    bno number(10,0),
    title VARCHAR2(200) not null,
    content VARCHAR2(2000) not null,
    writer VARCHAR2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
);

alter table tbl_board add constraint pk_board primary key (bno);

insert into tbl_board (bno, title, content,writer) 
values (seq_board.nextval,'�׽�Ʈ ����','�׽�Ʈ ����','user00');

commit;

select * from tbl_board;