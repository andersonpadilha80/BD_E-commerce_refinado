USE ecommerce_refinado;

-- consultas

-- Quantos clientes o BD possui?
SELECT COUNT(*) FROM clients;


-- Junção das tabelas clients e orders
SELECT * FROM clients AS c, orders AS o WHERE c.client_id = o.order_client_id;


-- Relação do nome e sobrenome de pessoas fisicas com os ids de seus respectivos pedidos e o status dos pedidos
SELECT client_first_name, client_last_name, order_id, order_status 
    FROM clients_pf AS c, orders AS o 
    WHERE c.client_pf_id = o.order_client_id;


-- Relação do nome e sobrenome concatenados de pessoas fisicas com os ids de seus respectivos pedidos e o status dos pedidos
SELECT concat(client_first_name,' ', client_last_name) AS Clientes_PF, order_id AS Pedidos, order_status AS Status_Pedido 
    FROM clients_pf AS c, orders AS o 
    WHERE c.client_pf_id = o.order_client_id;


-- Relação de pessoas jurídicas com os ids de seus respectivos pedidos e o status dos pedidos
SELECT client_social_name AS Empresas, order_id AS Pedidos, order_status AS Status_Pedido
    FROM clients_pj AS c, orders as o
    WHERE c.client_pj_id = o.order_client_id;


-- Relação de clientes pessoas físicas e seus pedidos agrupados por cliente    
SELECT c.client_pf_id, client_first_name, COUNT(*) AS Number_of_orders 
    FROM clients_pf AS c
    INNER JOIN orders AS o ON c.client_pf_id = o.order_client_id
    LEFT JOIN product_order AS p ON p.product_order_id = o.order_id
    GROUP BY client_pf_id;



-- Perguntas:

-- Quantos pedidos foram feitos por cada cliente?
SELECT order_client_id,
       COALESCE(clients_pf.client_first_name, clients_pj.client_social_name)AS Client_Name,
       COUNT(*) AS Number_of_orders
    FROM clients
    INNER JOIN orders ON client_id = order_client_id
    LEFT JOIN clients_pf ON client_id = client_pf_id
    LEFT JOIN clients_pj ON client_id = client_pj_id
    GROUP BY order_client_id, Client_Name;


-- Algum vendedor também é fornecedor?
SELECT * FROM sellers
    JOIN suppliers
    ON seller_cnpj = supplier_cnpj;


-- Relação de produtos, fornecedores e estoques;
SELECT product_name AS Product, supplier_social_name AS Social_Name, product_storage_quantity AS Storage_Quantity
    FROM products
    INNER JOIN product_supplier ON product_id = product_supplier_prod_id
    INNER JOIN suppliers ON supplier_id = product_supplier_id
    LEFT JOIN products_storage ON product_id = product_storage_id;


-- Relação de nomes dos fornecedores e nomes dos produtos;
SELECT supplier_social_name AS Supplier, product_name AS Product
    FROM suppliers
    INNER JOIN product_suppliers ON product_supplier_id = supplier_id
    INNER JOIN products ON product_id = product_supplier_prod_id;