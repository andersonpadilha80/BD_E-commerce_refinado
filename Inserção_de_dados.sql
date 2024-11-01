-- inserção de dados e queries
USE ecommerce_refinado;
SHOW TABLES;



-- inserir dados na tabela clients
-- client_id, client_type, client_address
INSERT INTO clients (client_type, client_address)
              VALUES('PF', 'Rua Silva de Prata 29, Carangola - Cidade das Flores'),
                    ('PF', 'Rua Alameda 289, Centro - Cidade das Flores'),
                    ('PF', 'Avenida Alameda Vinha 1009, Centro - Cidade das Flores'),
                    ('PF', 'Rua Lareiras 861, Centro - Cidade da Flores'),
                    ('PF', 'Avenida Koller 19, Centro - Cidade das Flores'),
                    ('PF', 'Rua Alameda das Flores 28, Centro - Cidade das Flores'),
                    ('PJ', 'Rua Visconde de Mauá 366, São Pelegrino - Caxias do Sul'),
                    ('PJ', 'Avenida Julio de Castilho 1001, Centro - Porto Alegre'),
                    ('PJ', 'Avenida Beira Mar 255, Centro - Florianópolis'),
                    ('PJ', 'Rua Botafogo 456, Pioneiro - Santa Maria');

SELECT * FROM clients;        



-- inserir dados na tabela clients_pf
-- client_pf_id, client_first_name, client_middle_name, client_last_name, client_cpf, client_date_of_birth
INSERT INTO clients_pf (client_pf_id, client_first_name, client_middle_name, client_last_name, client_cpf, client_date_of_birth)
                 VALUES(1, 'Maria', 'M', 'Silva', 12346789, '1960-01-02'),
                       (2, 'Matheus', 'O', 'Pimentel', 987654321, '1970-02-03'),
                       (3, 'Ricardo', 'F', 'Silva', 45678913, '1980-03-04'),
                       (4, 'Julia', 'S', 'França', 789123456, '1990-04-05'),
                       (5, 'Roberta', 'G', 'Assis', 98745631, '2000-05-06'),
                       (6, 'Isabela', 'M', 'Cruz', 654789123, '2010-06-07');

SELECT * FROM clients_pf;



-- inserir dados na tabela clients_pj
-- client_pj_id, client_social_name, client_cnpj
INSERT INTO clients_pj (client_pj_id, client_social_name, client_cnpj)
                 VALUES(7, 'Plastitec', 11999234000170),
                       (8, 'Estação dos Brinquedos', 10888123000169),
                       (9, 'Planeta Surf', 09777321000168),
                       (10, 'CSV Refrigerantes', 08666312000167);

SELECT * FROM clients_pj;



-- inserir dados na tabela products
-- product_id, product_name, product_value, product_class_kids, product_category('Eletrônico','Vestuário','Brinquedos','Alimentos','Móveis'), product_eval, product_size
INSERT INTO products (product_name, product_value, product_class_kids, product_category, product_eval, product_size)
              VALUES('Fone de ouvido', 50.80, FALSE, 'Eletrônico', '4', NULL),
                    ('Barbie Elsa', 165.51, TRUE, 'Brinquedos', '3', NULL),
                    ('Body Carters', 149.90, TRUE, 'Vestuário', '5', NULL),
                    ('Microfone Vedo - Youtuber', 185.95, FALSE, 'Eletrônico', '4', NULL),
                    ('Sofá retrátil', 1299.00, FALSE, 'Móveis', '3', '3x57x80'),
                    ('Farinha de arroz', 19.00, FALSE, 'Alimentos', '2', NULL),
                    ('Fire Stick Amazon', 314.10, FALSE, 'Eletrônico', '3', NULL),
                    ('Bermuda Freesurf', 167.40, FALSE, 'Vestuário', '4', NULL),
                    ('Cômoda', 499.00, FALSE, 'Móveis', '3', '94x91x47'),
                    ('Ração Premier', 232.78, FALSE, 'Alimentos', '5', NULL);

SELECT * FROM products;



-- inserir dados na tabela payments
-- payment_id, payment_client_id, payment_type('PIX','Cartão de Débito','Cartão de Crédito','Boleto Bancário') DEFAULT 'PIX', payment_limit_avail
INSERT INTO payments (payment_client_id, payment_type, payment_limit_avail)
               VALUES(8, DEFAULT, 500.00),
                     (2, 'Cartão de Débito', 50.00),
                     (5, 'Boleto Bancário', 133.22),
                     (4, 'PIX', 200.00),
                     (9, DEFAULT, 2000.00);

SELECT * FROM payments;


-- inserir dados na tabela orders
-- order_id, order_client_id, order_status, order_description, order_send_value, order_payment_method('PIX','Cartão de Débito','Cartão de Crédito','Boleto Bancário'), order_date
INSERT INTO orders (order_client_id, order_status, order_description, order_send_value, order_payment_method, order_date)
             VALUES(1, DEFAULT, 'compra via aplicativo', DEFAULT, 'Cartão de Débito', DEFAULT),
                   (2, DEFAULT, 'compra via aplicativo', 50, 'PIX', DEFAULT),
                   (3, 'Confirmado', NULL, NULL, 'Cartão de Crédito', '2024-10-26 15:30:00'),
                   (4, DEFAULT, 'compra via web site', 150, 'Boleto Bancário', '2024-05-17 14:00:00'),
                   (2, DEFAULT, 'compra via aplicativo', NULL, 'PIX', DEFAULT),
                   (10, 'Confirmado', 'compra via web site', 100, 'PIX', '2024-07-12 09:33:23');

SELECT *FROM orders;



-- inserir dados na tabela product_orders
-- product_order_id, product_order_ord_id, product_order_quantity, product_order_status
INSERT INTO product_order (product_order_id, product_order_ord_id, product_order_quantity, product_order_status)
                    VALUES(1, 1, 2, 'Disponível'),
                          (2, 1, 1, 'Disponível'),
                          (3, 2, 1, 'Disponível');
                         
SELECT * FROM product_orders;



-- inserir dados na tabela deliverys
-- delivery_id, delivery_order_id, delivery_status('Pendente', 'Em Transporte', 'Entregue', 'Cancelado'), delivery_track_code, delivery_date
INSERT INTO deliverys (delivery_order_id, delivery_status, delivery_track_code, delivery_date)
               VALUES(1, 'Pendente', '00123', '2024-10-31'),
                     (2, DEFAULT, '00124', '2024-11-02'),
                     (3, 'Em Transporte', '00125', '2024-10-28'),
                     (4, 'Pendente', '00126', '2024-11-15'),
                     (5, DEFAULT, '00127', '2024-12-23'),
                     (6, 'Entregue', '00128', '2024-08-12');

SELECT * FROM deliverys;



-- inserir dados na tabela storage_locations
-- storage_location_id, storage_location_address
INSERT INTO storage_locations (storage_location_id, storage_location_address)
                      VALUES(1, 'RJ'),
                            (2, 'GO'),
                            (3, 'RS');
                            
SELECT * FROM storage_locations;



-- inserir dados na tabela products_storage
-- product_storage_id, product_storage_loc_storage_id, product_storage_quantity
INSERT INTO products_storage (product_storage_id, product_storage_loc_storage_id, product_storage_quantity)
                     VALUES(1, 1, 1000),
                           (4, 1, 500),
                           (2, 2, 10),
                           (7, 3, 100),
                           (10, 3, 10),
                           (5, 2, 60);
                           
SELECT * FROM products_storage;


-- inserir dados na tabela suppliers
-- supplier_id, supplier_social_name, supplier_cnpj, supplier_contact_phone
INSERT INTO suppliers (supplier_social_name, supplier_cnpj, supplier_contact_phone)
               VALUES('Hipermercado Almeida', 12345678912345, '21985474'),
                     ('Eletrônicos Silva', 85451964914345, '21985484'),
                     ('Brinquedos Valma', 93456789393469, '21975474'),
                     ('Confecções Celli', 56734751000135, '51999234598'),
                     ('Center Móveis', 88234123000166, '3532234531');
                     
SELECT * FROM suppliers;


-- inserir dados na tabela product_supplier
-- product_supplier_id, product_supplier_prod_id, product_supplier_quantity
INSERT INTO product_supplier (product_supplier_id, product_supplier_prod_id, product_supplier_quantity)
                      VALUES(1, 6, 500),
                            (1, 10, 400),
                            (2, 1, 633),
                            (2, 4, 100),
                            (2, 7, 133),
                            (3, 2, 5),
                            (4, 3, 10),
                            (4, 8, 44),
                            (5, 5, 88),
                            (5, 9, 225);
                            
SELECT * FROM product_suppliers;


-- inserir dados na tabela sellers
-- seller_id, seller_social_name, seller_abst_name, seller_cnpj, seller_cpf, seller_location, seller_contact_phone
INSERT INTO sellers (seller_social_name, seller_abst_name, seller_cnpj, seller_cpf, seller_location, seller_contact_phone)
             VALUES('Tech Eletronics', NULL, 12345678945632, NULL, 'Rio de Janeiro', 219946287),
                   ('Botique Durgas', NULL, NULL, 123456783, 'Rio de Janeiro', 219567895),
                   ('Kids World', NULL, 45678912365448, NULL, 'São Paulo', 1198657484);
                   
SELECT * FROM sellers;


-- inserir dados na tabela product_seller
-- product_seller_id, product_seller_prod_id, product_seller_quantity_sold
INSERT INTO product_seller (product_seller_id, product_seller_prod_id, product_seller_quantity_sold)
                    VALUES(1, 1, 80),
                          (2, 3, 10),
                          (3, 2, 20),
                          (1, 4, 3),
                          (2, 5, 10),
                          (1, 7, 50),
                          (2, 8, 15);
                          
SELECT * FROM product_seller;