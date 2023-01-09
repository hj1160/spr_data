select * from tabs;

drop table report;
drop table reason_report;
drop table keyword;
drop table notification;
drop table evaluation;
drop table coupon;
drop table location;
drop table evaluate;
drop table authority;
drop table reply;
drop table block;
drop table score;
drop table review;
drop table wish;
drop table message;
drop table chat_user;
drop table chat_room;
drop table product_photo;
drop table product;
drop table board_photo;
drop table board;
drop table hashtag;
drop table category;
drop table member;

drop sequence seq_category;
drop sequence seq_hashtag;
drop sequence seq_board_photo;
drop sequence seq_product;
drop sequence seq_product_photo;
drop sequence seq_chat_room;
drop sequence seq_message;
drop sequence seq_wish;
drop sequence seq_review;
drop sequence seq_reply;
drop sequence seq_coupon;
drop sequence seq_evaluation;
drop sequence seq_notification;
drop sequence seq_keyword;
drop sequence seq_reason_report;
drop sequence seq_report;

--========================================
--          TABLE & SEQUENCE
--========================================
create table member
(
    user_id varchar2(50),
    password varchar2(50) not null,
    email varchar2(50),
    nickname varchar2(50) default '닉네임',
    address varchar2(100),
    original_filename varchar2(50) default 'default_profile.jpg',
    renamed_filename varchar2(50),
    enabled number default 1 not null,
    reg_date date default sysdate,
    quit_yn char(1) default 'N',
    constraint pk_member_user_id primary key(user_id),
    constraint ck_member_enabled check(enabled in(1, 2)),
    constraint ck_member_quit_yn check(quit_yn in('Y', 'N'))
);

create table category
(
    category_code number,
    category_parent number,
    category_name varchar2(50) not null,
    constraint pk_category primary key(category_code),
    constraint fk_category_category_parent foreign key(category_parent) references category(category_code)
);

create table hashtag
(
    hashtag_code number,
    hashtag_name varchar2(50) not null,
    constraint pk_hashtag primary key(hashtag_code)
);

create table board
(
    b_code number,
    user_id varchar2(50) not null,
    category_code number not null,
    board_title varchar2(100) not null,
    board_content varchar2(500) not null,
    reg_date date default sysdate,
    hashtag_code number,
    like_this number default 0 not null,
    constraint pk_board primary key(b_code),
    constraint fk_board_user_id foreign key(user_id) references member(user_id),
    constraint fk_board_category_code foreign key(category_code) references category(category_code),
    constraint fk_board_hashtag_code foreign key(hashtag_code) references hashtag(hashtag_code)
);

create table board_photo
(
    photo_code number not null, 
    b_code number,
    original_filename varchar2(100) not null,
    uuid varchar2(100) not null,
    upload_path varchar2(100),
    constraints pk_board_photo_code primary key(photo_code),
    constraints fk_photo_board_b_code foreign key(b_code) references board(b_code) on delete cascade
);

create table product
(
    p_code number,
    seller varchar2(50) not null,
    buyer varchar2(50),
    title varchar2(100) not null,
    category number not null,
    content varchar2(500) not null,
    price number not null,
    reg_date date default sysdate not null,
    open_status number default 1 not null,
    trade_status char(1) default 'S' not null,
    coupon number default 1 not null,
    offer number default 1 not null,
    delete_yn char(1) default 'y' not null,
    pull number default 0 not null,
    constraint pk_product primary key(p_code),
    constraint fk_product_seller foreign key(seller) references member(user_id),
    constraint fk_product_buyer foreign key(buyer) references member(user_id),
    constraint fk_product_category foreign key(category) references category(category_code),
    constraint ck_product_open_status check(open_status in (1,0)),
    constraint ck_product_trade_status check(trade_status in('S','R','C')),
    constraint ck_product_coupon check(coupon in(1,0)),
    constraint ck_product_offer check(offer in(1,0)),
    constraint ck_product_delete_yn check(delete_yn in('Y', 'N'),
    constraint ck_product_pull check(pull in(1, 0))
);

create table product_photo
(
    photo_code number,
    p_code number,
    original_filename varchar2(50) not null,
    uuid varchar2(50) not null,
    upload_path varchar2(100),
    constraint pk_product_photo_photo_code primary key(photo_code),
    constraint fk_product_photo_p_code foreign key(p_code) references product(p_code)
);

create table chat_room
(
    room_code number,
    p_code number not null,
    reg_date date default sysdate not null,
    constraint pk_chat_room primary key(room_code),
    constraint fk_chat_room_p_code foreign key(p_code) references product(p_code)
);

create table chat_user
(
    user_id varchar2(50),
    room_code number,
    enabled char(1) default 1 not null,
    constraint pk_chat_user primary key(user_id, room_code),
    constraint fk_chat_user_user_id foreign key(user_id) references member(user_id),
    constraint fk_chat_user_room_code foreign key(room_code) references chat_room(room_code),
    constraint ck_chat_user_enabled check(enabled in(1,0))
);

create table message
(
    msg_code number,
    room_code number not null,
    user_id varchar2(50) not null,
    chat_content varchar2(500),
    chat_date date default sysdate not null,
    original_filename varchar2(50),
    renamed_filename varchar2(50),
    constraint pk_message primary key(msg_code),
    constraint fk_message_room_code foreign key(room_code) references chat_room(room_code),
    constraint fk_message_user_id foreign key(user_id) references member(user_id)
);

create table wish
(
    wish_code number,
    user_id varchar2(50) not null,
    p_code number not null,
    constraint pk_wish primary key(wish_code),
    constraint fk_user_id foreign key(user_id) references member(user_id),
    constraint fk_wish_p_code foreign key(p_code) references product(p_code),
    constraint uq_wish_id_pcode unique(user_id, p_code)
);

create table review
(
    review_code number,
    sender varchar2(50) not null,
    recipient varchar2(50) not null,
    content varchar2(500) not null,
    direct char(1) not null,
    p_code number not null,
    constraint pk_review primary key(review_code),
    constraint fk_review_seller foreign key(seller) references member(user_id),
    constraint fk_review_buyer foreign key(buyer) references member(user_id),
    constraint ck_review_direct check (direct in('S', 'B')),
    constraint fk_review_p_code foreign key(p_code) references product(p_code)
);
delete from review;
create table score
(
    user_id varchar2(50),
    total_score number default 0 not null,
    count number default 0 not null,
    constraint pk_score primary key(user_id),
    constraint fk_score_user_id foreign key(user_id) references member(user_id)
);

create table block
(
    user_id varchar2(50),
    block_id varchar2(50),
    constraint pk_block primary key(user_id, block_id),
    constraint fk_block_user_id foreign key(user_id) references member(user_id),
    constraint fk_block_block_id foreign key(block_id) references member(user_id)
);

create table reply
(
    reply_code number,
    reply_level number default 1 not null,
    user_id varchar2(50) not null,
    content varchar2(500) not null,
    b_code number,
    reply_ref number,
    reg_date date default sysdate not null,
    constraint pk_reply primary key(reply_code),
    constraint ck_reply_reply_level check(reply_level in(1,2)),
    constraint fk_reply_user_id foreign key(user_id) references member(user_id),
    constraint fk_reply_b_code foreign key(b_code) references board(b_code) on delete cascade,
    constraint fk_reply_reply_ref foreign key(reply_ref) references reply(reply_code)
);

create table authority
(
    auth varchar2(5) default 'ROLE_USER',
    user_id varchar2(50),
    constraint pk_authority primary key(auth, user_id),
    constraint fk_authority_user_id foreign key(user_id) references member(user_id)
);

create table evaluate
(
    eva_code number,
    user_id varchar2(50),
    count number default 0 not null,
    constraint pk_evaluate primary key(user_id, eva_code),
    constraint fk_evaluate_user_id foreign key(user_id) references member(user_id)
);

create table location
(
    user_id varchar2(50),
    latitude number(10,6),
    longitude number(10,6),
    radius number,
    constraint pk_location primary key(user_id),
    constraint fk_location_user_id foreign key(user_id) references member(user_id)
);

create table coupon
(
    coupon_code number,
    user_id varchar2(50) not null,
    coupon_name varchar2(50) not null,
    expire_date date default sysdate+7 not null,
    usage_status number default 0 not null,
    constraint pk_coupon primary key(coupon_code),
    constraint fk_coupon_user_id foreign key(user_id) references member(user_id),
    constraint ck_coupon_usage_status check(usage_status in(1,0))
);

create table evaluation
(
    eva_code number,
    content varchar2(100) not null,
    kind number not null,
    member char(1) not null,
    constraint pk_evaluation primary key(eva_code),
    constraint ck_evaluation_kind check(kind in(1, 0)),
    constraint ck_evaluation_member check(member in('S', 'B', 'C'))
);

create table notification
(
    noti_code number,
    p_code number,
    p_title varchar2(100),
    receiver varchar2(50),
    sender varchar2(50),
    kind varchar2(10),
    noti_content varchar2(200),
    noti_check number,
    constraint pk_notification_noti_code primary key(noti_code),
    constraint fk_notification_p_code foreign key(p_code) references product(p_code),
    constraint fk_notification_receiver foreign key(receiver) references member(user_id),
    constraint fk_notification_sender foreign key(sender) references member(user_id),
    constraint ck_notification_kind check (kind in('reply', 'price', 'nego', 'keyword', 'like')),
    constraint ck_notification_noti_check check(noti_check in(1, 0))
);

create table keyword
(
    key_code number,
    user_id varchar2(50) not null,
    key_content varchar2(100) not null,
    constraint pk_keyword primary key(key_code),
    constraint fk_keyword_user_id foreign key(user_id) references member(user_id)
);

create table reason_report
(
    reason_code number,
    reason_content varchar2(100) not null,
    parent_code number,
    constraint pk_reason_report primary key(reason_code),
    add constraint reason_report_parent_code foreign key (parent_code) references reason_report(reason_code)
);

create table report
(
    report_code number,
    reason_code number not null,
    report_id varchar2(50) not null,
    shooter_id varchar2(50),
    b_code number,
    reply_code number,
    checked number default 0 not null,
    p_code number,
    content varchar2(500),
    constraint pk_report primary key(report_code),
    constraint fk_report_reason_code foreign key(reason_code) references reason_report(reason_code),
    constraint fk_report_report_id foreign key(report_id) references member(user_id),
    constraint fk_report_shooter_id foreign key(shooter_id) references member(user_id),
    constraint fk_report_b_code foreign key(b_code) references board(b_code),
    constraint fk_report_reply_code foreign key(reply_code) references reply(reply_code),
    constraint fk_report_checked check(checked in(1,0)),
    constraint fk_report_p_code foreign key (p_code) references product(p_code)
);

create table like_this
(
    b_code number not null, 
    user_id varchar2(20) not null, 
    constraints pk_like_this primary key(b_code, user_id), 
    constraints fk_board_b_code foreign key(b_code) references board(b_code) on delete cascade, 
    constraints fk_member_user_id foreign key(user_id) references member(user_id) 
);

create sequence seq_category;
create sequence seq_hashtag;
create sequence seq_board_photo;
create sequence seq_product;
create sequence seq_product_photo;
create sequence seq_chat_room;
create sequence seq_message;
create sequence seq_wish;
create sequence seq_review;
create sequence seq_reply;
create sequence seq_coupon;
create sequence seq_evaluation;
create sequence seq_notification;
create sequence seq_keyword;
create sequence seq_reason_report;
create sequence seq_report;
create sequence seq_member;
create sequence seq_location;

--========================================
--            FUNCTION
--========================================
-- 거리 구하기 함수
-- 좋아요 트리거


--========================================
--            DATA
--========================================
------- CATEGORY -------
insert into category values(seq_category.nextval, null, '상품'); -- 1
insert into category values(seq_category.nextval, null, '게시판'); -- 2
insert into category values(seq_category.nextval, null, '관리자'); -- 21
insert into category values(seq_category.nextval, 21, '공지사항');
insert into category values(seq_category.nextval, 21, '자주 묻는 질문');
insert into category values(seq_category.nextval, 1, '디지털/가전');
insert into category values(seq_category.nextval, 1, '가구/인테리어');
insert into category values(seq_category.nextval, 1, '유아동/유아도서');
insert into category values(seq_category.nextval, 1, '생활/가공식품');
insert into category values(seq_category.nextval, 1, '스포츠/레저');
insert into category values(seq_category.nextval, 1, '여성잡화');
insert into category values(seq_category.nextval, 1, '여성의류');
insert into category values(seq_category.nextval, 1, '남성패션/잡화');
insert into category values(seq_category.nextval, 1, '게임/취미');
insert into category values(seq_category.nextval, 1, '뷰티/미용');
insert into category values(seq_category.nextval, 1, '반려동물용품');
insert into category values(seq_category.nextval, 1, '도서/티켓/음반');
insert into category values(seq_category.nextval, 1, '기타 중고물품');
insert into category values(seq_category.nextval, 1, '삽니다');
insert into category values(seq_category.nextval, 2, '동네생활이야기');
insert into category values(seq_category.nextval, 2, '우리동네질문');
insert into category values(seq_category.nextval, 2, '분실/실종센터');
insert into category values(seq_category.nextval, 2, '동네사건사고');
------- HASHTAG -------
insert into hashtag values(1, '강아지');
insert into hashtag values(2, '고양이');
insert into hashtag values(3, '건강');
insert into hashtag values(4, '동네맛집');
insert into hashtag values(5, '동네카페');
insert into hashtag values(6, '살림/청소/정리');
insert into hashtag values(7, '식물');
insert into hashtag values(8, '임신/출산/육아');
insert into hashtag values(9, '집꾸미기');
------- EVALUATION -------
insert into evaluation values(seq_evaluation.nextval, '제가 있는 곳 까지 와서 거래했어요', 1, 'S');
insert into evaluation values(seq_evaluation.nextval, '무료로 나눠주셨어요', 1, 'B');
insert into evaluation values(seq_evaluation.nextval, '상품상태가 설명한 것과 같아요', 1, 'B');
insert into evaluation values(seq_evaluation.nextval, '상품설명이 자세해요', 1, 'B');
insert into evaluation values(seq_evaluation.nextval, '좋은 상품을 저렴하게 판매해요', 1, 'B');
insert into evaluation values(seq_evaluation.nextval, '시간약속을 잘 지켜요', 1, 'C');
insert into evaluation values(seq_evaluation.nextval, '응답이 빨라요', 1, 'C');
insert into evaluation values(seq_evaluation.nextval, '친절하고 매너가 좋아요', 1, 'C');
insert into evaluation values(seq_evaluation.nextval, '단순 변심으로 환불을 요구해요', 0, 'S');
insert into evaluation values(seq_evaluation.nextval, '무리하게 가격을 깎아요', 0, 'S');
insert into evaluation values(seq_evaluation.nextval, '불친절해요', 0, 'S');
insert into evaluation values(seq_evaluation.nextval, '예약만 해놓고 거래 시간을 명확하게 알려주지 않아요', 0, 'S');
insert into evaluation values(seq_evaluation.nextval, '상품 가치없는 물건을 팔아요', 0, 'B');
insert into evaluation values(seq_evaluation.nextval, '상품 상태가 설명과 달라요', 0, 'B');
insert into evaluation values(seq_evaluation.nextval, '상품 설명에 중요한 정보가 누락됐어요', 0, 'B');
insert into evaluation values(seq_evaluation.nextval, '구매 가격보다 비싼 가격으로 판매해요', 0, 'B');
insert into evaluation values(seq_evaluation.nextval, '이 분과 다시는 거래하고 싶지 않아요', 0, 'C');
insert into evaluation values(seq_evaluation.nextval, '너무 늦은 시간이나 새벽에 연락해요', 0, 'C');
insert into evaluation values(seq_evaluation.nextval, '반말을 사용해요', 0, 'C');
insert into evaluation values(seq_evaluation.nextval, '시간약속을 안 지켜요', 0, 'C');
insert into evaluation values(seq_evaluation.nextval, '차에서 내리지도 않고 창문만 열고 거래하려고 해요', 0, 'C');
insert into evaluation values(seq_evaluation.nextval, '무조건 택배거래만 하려고 해요', 0, 'C');
insert into evaluation values(seq_evaluation.nextval, '질문해도 답이 없어요', 0, 'C');
insert into evaluation values(seq_evaluation.nextval, '거래 시간과 장소를 정한 후 연락이 안돼요', 0, 'C');
insert into evaluation values(seq_evaluation.nextval, '약속 장소에 나타나지 않았어요', 0, 'C');
insert into evaluation values(seq_evaluation.nextval, '거래 시간과 장소를 정한 후 거래 직전 취소했어요', 0, 'C');
------- REASON_REPORT -------
insert into reason_report values(seq_reason_report.nextval, '상품 신고', null);
insert into reason_report values(seq_reason_report.nextval, '판매금지 품목이에요', 1);
insert into reason_report values(seq_reason_report.nextval, '재난지원금/쌀 꾸러미 거래', 5);
insert into reason_report values(seq_reason_report.nextval, '반려동물 거래', 5);
insert into reason_report values(seq_reason_report.nextval, '주류/담배 판매', 5);
insert into reason_report values(seq_reason_report.nextval, '화장품 샘플 판매', 5);
insert into reason_report values(seq_reason_report.nextval, '청소년 유해물/음란물 판매', 5);
insert into reason_report values(seq_reason_report.nextval, '가품/이미테이션 판매', 5);
insert into reason_report values(seq_reason_report.nextval, '의약품/의료기기 판매', 5);
insert into reason_report values(seq_reason_report.nextval, '콘택트 렌즈/도수 있는 안경 판매', 5);
insert into reason_report values(seq_reason_report.nextval, '수제 음식/미인증 건강기능식품 판매', 5);
insert into reason_report values(seq_reason_report.nextval, '조건부 무료나눔', 5);
insert into reason_report values(seq_reason_report.nextval, '중고거래 게시글이 아니에요', 1);
insert into reason_report values(seq_reason_report.nextval, '지역업체 소개/광고', 6);
insert into reason_report values(seq_reason_report.nextval, '부동산 거래', 6);
insert into reason_report values(seq_reason_report.nextval, '중고차/오토바이 판매', 6);
insert into reason_report values(seq_reason_report.nextval, '농수산물 판매', 6);
insert into reason_report values(seq_reason_report.nextval, '구인구직', 6);
insert into reason_report values(seq_reason_report.nextval, '과외/클래스 모집', 6);
insert into reason_report values(seq_reason_report.nextval, '전시/공연/행사', 6);
insert into reason_report values(seq_reason_report.nextval, '비방/저격', 6);
insert into reason_report values(seq_reason_report.nextval, '일반 게시글(잡담, 질문 등)', 6);
insert into reason_report values(seq_reason_report.nextval, '전문 판매업자 같아요', 1);
insert into reason_report values(seq_reason_report.nextval, '매장이 있는 판매업자', 7);
insert into reason_report values(seq_reason_report.nextval, '인터넷 쇼핑몰 판매업자', 7);
insert into reason_report values(seq_reason_report.nextval, '대량 주문 판매', 7);
insert into reason_report values(seq_reason_report.nextval, '점포 재고 정리', 7);
insert into reason_report values(seq_reason_report.nextval, '해외 구매 대행', 7);
insert into reason_report values(seq_reason_report.nextval, '사기글 같아요', 1);
insert into reason_report values(seq_reason_report.nextval, '카카오톡/안전결제 등으로 유도', 8);
insert into reason_report values(seq_reason_report.nextval, '사기 신고', 8);
insert into reason_report values(seq_reason_report.nextval, '기타 사유 선택', 1);
insert into reason_report values(seq_reason_report.nextval, '판매 가치가 없는 상품', 9);
insert into reason_report values(seq_reason_report.nextval, '중복 게시글', 9);
insert into reason_report values(seq_reason_report.nextval, '잘못된 카테고리', 9);
insert into reason_report values(seq_reason_report.nextval, '상품 설명 부족', 9);
insert into reason_report values(seq_reason_report.nextval, '마스크 판매 정책 위반', 9);
insert into reason_report values(seq_reason_report.nextval, '당근마켓에서 구매 후 비싸게 재판매', 9);
insert into reason_report values(seq_reason_report.nextval, '사용자 신고', null);
insert into reason_report values(seq_reason_report.nextval, '전문 판매업자 같아요', 2);
insert into reason_report values(seq_reason_report.nextval, '비매너 사용자에요', 2);
insert into reason_report values(seq_reason_report.nextval, '욕설을 해요', 2);
insert into reason_report values(seq_reason_report.nextval, '성희롱을 해요', 2);
insert into reason_report values(seq_reason_report.nextval, '동네생활 신고', null);
insert into reason_report values(seq_reason_report.nextval, '광고/홍보 글이에요', 3);
insert into reason_report values(seq_reason_report.nextval, '구인구직 글이에요', 48);
insert into reason_report values(seq_reason_report.nextval, '부동산 거래 글이에요', 48);
insert into reason_report values(seq_reason_report.nextval, '업체 홍보글이에요', 48);
insert into reason_report values(seq_reason_report.nextval, '중고거래 게시글이에요', 3);
insert into reason_report values(seq_reason_report.nextval, '중고거래 관련 문의/신고 글이에요', 3);
insert into reason_report values(seq_reason_report.nextval, '반려동물 분양/교배 글이에요', 3);
insert into reason_report values(seq_reason_report.nextval, '부적절한 글이에요', 3);
insert into reason_report values(seq_reason_report.nextval, '셀카나 개인정보가 포함되어 있어요', 52);
insert into reason_report values(seq_reason_report.nextval, '분쟁/논란이 될 만한 글이에요', 52);
insert into reason_report values(seq_reason_report.nextval, '금전/물품 요구하는 글이에요', 52);
insert into reason_report values(seq_reason_report.nextval, '연애 대상을 구하는 글이에요', 52);
insert into reason_report values(seq_reason_report.nextval, '중독/도배성 게시글이에요', 52);
insert into reason_report values(seq_reason_report.nextval, '불쾌감을 줄 수 있는 사진이에요', 52);
insert into reason_report values(seq_reason_report.nextval, '음란성 글이에요', 52);
insert into reason_report values(seq_reason_report.nextval, '이웃을 배제하거나 비방하는 글이에요', 3);
insert into reason_report values(seq_reason_report.nextval, '차별/혐오 표현을 사용해요', 53);
insert into reason_report values(seq_reason_report.nextval, '욕설을 해요', 53);
insert into reason_report values(seq_reason_report.nextval, '특정 유저 혹은 이웃을 비방해요', 53);
insert into reason_report values(seq_reason_report.nextval, '자신들만 아는 이야기나 은어를 사용해요', 53);
insert into reason_report values(seq_reason_report.nextval, '특정 업체를 비방해요', 53);
insert into reason_report values(seq_reason_report.nextval, '댓글 신고', null);
insert into reason_report values(seq_reason_report.nextval, '음란성 댓글이에요', 4);
insert into reason_report values(seq_reason_report.nextval, '광고/홍보 댓글이에요', 4);
insert into reason_report values(seq_reason_report.nextval, '욕설이 포함된 댓글이에요', 4);
insert into reason_report values(seq_reason_report.nextval, '반려동물 분양/교배 댓글이에요', 4);
insert into reason_report values(seq_reason_report.nextval, '업체를 비방하는 댓글이에요', 4);
insert into reason_report values(seq_reason_report.nextval, '이웃을 비방하는 댓글이에요', 4);
insert into reason_report values(seq_reason_report.nextval, '중복/도배 댓글이에요', 4);
insert into reason_report values(seq_reason_report.nextval, '셀카나 개인정보가 포함되어 있어요', 4);
insert into reason_report values(seq_reason_report.nextval, '분쟁/논란이 될 만한 댓글이에요', 4);
select * from reason_report;
--========================================
--            DUMMY DATA
--========================================
------- PRODUCT -------
insert into product values
(SEQ_PRODUCT.nextval, 'test', null, '아이패드 프로 3세대 64기가', 3, '미개봉 새제품 판매합니다',
 580000, default, 1, 'S', 0, 1, 'N');
insert into product values
(SEQ_PRODUCT.nextval, 'test', null, '애플워치 5', 3, '개봉만 해본 새 제품 이예요',
280000, default, 1, 'S', 0, 1, 'N');
insert into product values
(SEQ_PRODUCT.nextval, 'test', 'juwon', '닌텐도 스위치 동물의 숲 에디션', 3, '128기가 본체 + 조이콘 외 모두 새 상품 그대로 입니다!',
 450000, default, 1, 'C', 0, 0, 'N');
insert into product values
(SEQ_PRODUCT.nextval, 'test', null, '마리오 카트', 3, '마리오 카트 구합니다! 강남역에서 직거래 원합니다',
 50000, default, 0, 'C', 0, 0, 'N');
insert into product values
(SEQ_PRODUCT.nextval, 'test', null, '플스4 + 조이스틱', 3, '용산에서 구매했습니다. 플스4 슬림 500기가, 컨트롤러2개, 조이스틱 2개 같이 드립니다.',
250000, default, 1, 'R', 0, 0, 'N');
insert into product values
(SEQ_PRODUCT.nextval, 'test', null, '에어팟 1세대 오른쪽 유닛', 3, '상태 좋아요 연락 주세요~',
25000, default, 1, 'S', 0, 0, 'Y');
insert into product values
(SEQ_PRODUCT.nextval, 'test', null, '네이버 클로바 인공지능 AI 블루투스 스피커', 3, '멜론 유저라 카카오스피커로 갈아타서 판매합니다 작동 잘되고 깨끗해요~',
18000, default, 1, 'S', 0, 1, 'N'); 
insert into product values
(SEQ_PRODUCT.nextval, 'juwon', null, '갤럭시 버즈', 3, '구성품은 박스, 이어팁, 기기 단품 입니다.',
80000, default, 1, 'S', 0, 1, 'N');
insert into product values
(SEQ_PRODUCT.nextval, 'juwon', null, '아이폰 정품 충전기', 3, '한번도 사용 안했어요 편하게 연락주세요',
200000, default, 1, 'S', 0, 1, 'N');
insert into product values
(SEQ_PRODUCT.nextval, 'juwon', 'test', 'K403S 삼성 정품 프린터 토너 판매합니다', 3, '삼성 레이저 프린트 토너 검정색 개봉하지 않은 새 상품입니다!',
300000, default, 1, 'C', 1, 1, 'N');
------- BOARD -------
insert into board values(SEQ_BOARD_NO.nextval, 'test', 17, '테스트입니다', '안녕하세요 반갑습니다', sysdate, null, 0);
insert into board values(SEQ_BOARD_NO.nextval, 'test', 18, '질문입니다', '질문질문', sysdate, null, 0);
insert into board values(SEQ_BOARD_NO.nextval, 'test', 19, '분실됐습니다', '찾아주세요', sysdate, null, 0);
insert into board values(SEQ_BOARD_NO.nextval, 'test', 20, '사건입니다', '큰일났네요', sysdate, null, 0);
insert into board values(SEQ_BOARD_NO.nextval, 'test', 17, '장문 테스트', '안녕 오늘도 같은 자리 버스 창가에 기대 앉은 네게 인사를 해 역시 넌 받아 주지를 않네 인기 많고 잘생긴 넌 내게만 그렇게 쌀쌀하게 굴더라', sysdate, null, 0);
insert into board values(SEQ_BOARD_NO.nextval, 'test', 17, '더 긴 장문 테스트', '중앙방역대책본부는 24일 0시 기준으로 국내 코로나바이러스 감염증(코로나19) 신규 확진자가 125명 늘어 누적 2만3341명이라고 밝혔다. 신규 확진자 수는 전날 110명에 이어 이틀 연속 세 자릿수를 나타냈다. 앞서 국내 신규 확진자는 지난달 14일부터 이달 19일까지 37일 연속 세 자릿수를 기록했었다.', sysdate, null, 0);
------- COUPON -------
insert into coupon values(seq_coupon.nextval, 'test', '강남구 11월 판매왕', to_date(to_char(sysdate + 7, 'yyyy-mm-dd'), 'yyyy-mm-dd'), 0);
------- MEMBER -------
insert into member values('test', '1234', 'test@naver.com', null, null, null, null, 1, sysdate, 'N');
------- EVALUATE -------
insert into evaluate values(1, 'test', 1);
insert into evaluate values(2, 'test', 1);
insert into evaluate values(3, 'test', 1);
insert into evaluate values(4, 'test', 1);
insert into evaluate values(5, 'test', 9);
insert into evaluate values(6, 'test', 8);
insert into evaluate values(10, 'test', 1);
insert into evaluate values(26, 'test', 1);
------- REVIEW -------
insert into review values(seq_review.nextval, 'juwon', 'test', '근처까지 와주셔서 감사합니다', 'B', 23);
insert into review values(seq_review.nextval, 'test', 'juwon', '쿨거래 감사합니다. 닌텐도 잘 작동하네요 재미있게 사용하겠습니다', 'S', 23);
------- KEYWORD -------
insert into keyword values(SEQ_KEYWORD.nextval, 'test', '애플');
insert into keyword values(SEQ_KEYWORD.nextval, 'test', '아이폰');
insert into keyword values(SEQ_KEYWORD.nextval, 'juwon', '삼성');
insert into keyword values(SEQ_KEYWORD.nextval, 'juwon', '갤럭시');
--==========================================================================================