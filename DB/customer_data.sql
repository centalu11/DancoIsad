PGDMP     8    7            
    w         
   bunny_demo    9.5.19    9.5.19 
    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �            1259    16421    customer_data    TABLE     $  CREATE TABLE public.customer_data (
    pk integer NOT NULL,
    email text,
    contact_number text,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false,
    tin text,
    client_name text NOT NULL,
    street text NOT NULL,
    city text NOT NULL
);
 !   DROP TABLE public.customer_data;
       public         postgres    false            �            1259    16430    customer_data_pk_seq    SEQUENCE     }   CREATE SEQUENCE public.customer_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.customer_data_pk_seq;
       public       postgres    false    186            �           0    0    customer_data_pk_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.customer_data_pk_seq OWNED BY public.customer_data.pk;
            public       postgres    false    187            ;           2604    16604    pk    DEFAULT     t   ALTER TABLE ONLY public.customer_data ALTER COLUMN pk SET DEFAULT nextval('public.customer_data_pk_seq'::regclass);
 ?   ALTER TABLE public.customer_data ALTER COLUMN pk DROP DEFAULT;
       public       postgres    false    187    186            �          0    16421    customer_data 
   TABLE DATA                     public       postgres    false    186   �	       �           0    0    customer_data_pk_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.customer_data_pk_seq', 12, true);
            public       postgres    false    187            =           2606    16627    customer_data_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.customer_data
    ADD CONSTRAINT customer_data_pkey PRIMARY KEY (pk);
 J   ALTER TABLE ONLY public.customer_data DROP CONSTRAINT customer_data_pkey;
       public         postgres    false    186    186            �   �  x�͒Ko� ���w�V�X��_�Iuai�P��6"�IP1X�[u~�����Q��tc�8��ç��n�7;howw0�%y�G�M/�c�����T	p�=�~��� lA �܊��`���S\y��XI����"�>J�r	?W?��p��[?.E7�����=�qYb�ה�-A�^`� %�P� �bZu�UA��)��1��`#3;�O�(s�<�t�e]�%���h	�'���Xز���i/���S��GXǚ���b"��ԝe���))�@ ��E�PZ����c+���OR�a�Z8h5O���<6�?>��jtQ�`��7a��^��(ƚ{���;�� [N�"cR�U���AE��YI�sb��'�jj9�)%o	����zs�J(q�s�ބF�èʂ�y�9Z49IiN
�O|jR�����~q��,���lI<yc0��+�W�     