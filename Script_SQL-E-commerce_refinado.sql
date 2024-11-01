-- criação do banco de dados para o cenário de E-commerce
-- DROP DATABASE ecommerce_refinado;

SHOW TABLES;

CREATE DATABASE ecommerce_refinado;
USE ecommerce_refinado;

-- criar tabela clientes
CREATE TABLE clients (
    client_id INT NOT NULL AUTO_INCREMENT,
    client_type ENUM('PF', 'PJ') NOT NULL,
    client_address VARCHAR(100),
    CONSTRAINT pk_client PRIMARY KEY (client_id)
) AUTO_INCREMENT=1;


-- criar tabela clientes PF
CREATE TABLE clients_pf(
    client_pf_id INT NOT NULL,
    client_first_name VARCHAR(45) NOT NULL,
    client_middle_name CHAR(3),
    client_last_name VARCHAR(45) NOT NULL,
    client_cpf CHAR(11) NOT NULL,
    client_date_of_birth DATE NOT NULL,
    CONSTRAINT pk_client_pf PRIMARY KEY (client_pf_id),
    CONSTRAINT fk_client_pf FOREIGN KEY (client_pf_id) REFERENCES clients(client_id),
    CONSTRAINT unique_client_cpf UNIQUE (client_cpf)
);


-- criar tabela clientes PJ
CREATE TABLE clients_pj(
    client_pj_id INT NOT NULL,
    client_social_name VARCHAR(100) NOT NULL,
    client_cnpj CHAR(14) NOT NULL,
    CONSTRAINT pk_client_pj PRIMARY KEY (client_pj_id),
    CONSTRAINT fk_client_pj FOREIGN KEY (client_pj_id) REFERENCES clients(client_id),
    CONSTRAINT unique_client_cnpj UNIQUE (client_cnpj)
);


-- criar tabela produto
-- evaluation = avaliação
-- size = tamanho do produto
CREATE TABLE products(
    product_id INT NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(45) NOT NULL,
    product_value FLOAT NOT NULL,
    product_class_kids BOOL DEFAULT FALSE,
    product_category ENUM('Eletrônico','Vestuário','Brinquedos','Alimentos','Móveis') NOT NULL,
    product_eval FLOAT DEFAULT 0,
    product_size VARCHAR(10),
    CONSTRAINT pk_product PRIMARY KEY (product_id)
) AUTO_INCREMENT=1;


-- para ser continuado no desafio: termine de implementar a tabela e crie a conexão com as tabelas necessárias
-- além disso, reflita essa modificação no diagrama de esquema relacional
-- criar constraints relacionadas ao pagamento
CREATE TABLE payments(
    payment_id INT NOT NULL AUTO_INCREMENT,
    payment_client_id INT NOT NULL,
    payment_type ENUM('PIX','Cartão de Débito','Cartão de Crédito','Boleto Bancário') DEFAULT 'PIX',
    payment_limit_avail FLOAT,
    CONSTRAINT pk_payment PRIMARY KEY (payment_id),
    CONSTRAINT fK_payment_client FOREIGN KEY (payment_client_id) REFERENCES clients(client_id)
) AUTO_INCREMENT=1;


-- criar tabela pedidos
CREATE TABLE orders(
    order_id INT NOT NULL AUTO_INCREMENT,
    order_client_id INT NOT NULL,
    order_status ENUM('Cancelado','Confirmado','Em Processamento') DEFAULT 'Em Processamento',
    order_description VARCHAR(255),
    order_send_value FLOAT DEFAULT 10,
    order_payment_method ENUM('PIX','Cartão de Débito','Cartão de Crédito','Boleto Bancário') DEFAULT 'PIX',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_order PRIMARY KEY (order_id),
    CONSTRAINT fk_order_client FOREIGN KEY (order_client_id) REFERENCES clients(client_id)
) AUTO_INCREMENT=1;


-- criar tabela entregas
CREATE TABLE deliverys(
    delivery_id INT NOT NULL AUTO_INCREMENT,
    delivery_order_id INT NOT NULL,
    delivery_status ENUM('Pendente', 'Em Transporte', 'Entregue', 'Cancelado') DEFAULT 'Pendente',
    delivery_track_code VARCHAR(50) NOT NULL,
    delivery_date DATE,
    CONSTRAINT pk_delivery PRIMARY KEY (delivery_id),
    CONSTRAINT fk_delivery_order FOREIGN KEY (delivery_order_id) REFERENCES orders(order_id)
) AUTO_INCREMENT=1;


-- criar tabela Local_de_Estoque
CREATE TABLE storage_locations(
    storage_location_id INT NOT NULL AUTO_INCREMENT,
    storage_location_address VARCHAR(255) NOT NULL,
    CONSTRAINT pk_storage_location PRIMARY KEY (storage_location_id)
) AUTO_INCREMENT=1;


-- criar tabela fornecedor
CREATE TABLE suppliers(
    supplier_id INT NOT NULL AUTO_INCREMENT,
    supplier_social_name VARCHAR(255) NOT NULL,
    supplier_cnpj CHAR(14) NOT NULL,
    supplier_contact_phone CHAR(11) NOT NULL,
    CONSTRAINT pk_supplier PRIMARY KEY (supplier_id),
    CONSTRAINT unique_supplier_cnpj UNIQUE (supplier_cnpj)
) AUTO_INCREMENT=1;


-- criar tabela vendedores
CREATE TABLE sellers(
    seller_id INT NOT NULL AUTO_INCREMENT,
    seller_social_name VARCHAR(255) NOT NULL,
    seller_abst_name VARCHAR(255),
    seller_cnpj CHAR(14),
    seller_cpf CHAR(11),
    seller_location VARCHAR(255),
    seller_contact_phone CHAR(11) NOT NULL,
    CONSTRAINT pk_seller PRIMARY KEY (seller_id),
    CONSTRAINT unique_seller_social_name UNIQUE (seller_social_name),
    CONSTRAINT unique_seller_cnpj UNIQUE (seller_cnpj),
    CONSTRAINT unique_seller_cpf UNIQUE (seller_cpf)
) AUTO_INCREMENT=1;


-- criar tabela Produto_Vendedor
CREATE TABLE product_seller(
    product_seller_id INT NOT NULL,
    product_seller_prod_id INT NOT NULL,
    product_seller_quantity_sold INT DEFAULT 1,
    CONSTRAINT pk_product_seller PRIMARY KEY (product_seller_id, product_seller_prod_id),
    CONSTRAINT fk_product_seller FOREIGN KEY (product_seller_id) REFERENCES sellers(seller_id),
    CONSTRAINT fk_product_seller_prod FOREIGN KEY (product_seller_prod_id) REFERENCES products(product_id)
);


-- criar tabela Produto_Pedido
CREATE TABLE product_order(
    product_order_id INT NOT NULL,
    product_order_ord_id INT NOT NULL,
    product_order_quantity INT DEFAULT 1,
    product_order_status ENUM('Disponível','Sem estoque') DEFAULT 'Disponível',
    CONSTRAINT pk_product_order PRIMARY KEY (product_order_id, product_order_ord_id),
    CONSTRAINT fk_product_order FOREIGN KEY (product_order_id) REFERENCES products(product_id),
    CONSTRAINT fk_product_order_ord FOREIGN KEY (product_order_ord_id) REFERENCES orders(order_id)
);


-- criar tabela Produto_Estoque
CREATE TABLE products_storage(
    product_storage_id INT NOT NULL,
    product_storage_loc_storage_id INT NOT NULL,
    product_storage_quantity INT DEFAULT 0,
    CONSTRAINT pk_product_storage_loc_storage PRIMARY KEY (product_storage_id, product_storage_loc_storage_id),
    CONSTRAINT fk_product_storage FOREIGN KEY (product_storage_id) REFERENCES products(product_id),
    CONSTRAINT fk_product_storage_loc_storage FOREIGN KEY (product_storage_loc_storage_id) REFERENCES storage_locations(storage_location_id)
);


-- criar tabela Produto_Fornecedor
CREATE TABLE product_supplier(
    product_supplier_id int NOT NULL,
    product_supplier_prod_id int NOT NULL,
    product_supplier_quantity INT NOT NULL,
    CONSTRAINT pk_product_supplier_prod PRIMARY KEY (product_supplier_id, product_supplier_prod_id),
    CONSTRAINT fk_product_supplier FOREIGN KEY (product_supplier_id) REFERENCES suppliers(supplier_id),
    CONSTRAINT fk_product_supplier_prod FOREIGN KEY (product_supplier_prod_id) REFERENCES products(product_id)
);