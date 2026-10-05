USE ecommerce;
CREATE TABLE sales (
    sales_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    invoice_no VARCHAR(20) NOT NULL,
    stock_code VARCHAR(20) NOT NULL,
    description VARCHAR(255),
    quantity INT NOT NULL,
    invoice_date DATETIME NOT NULL,
    unit_price DECIMAL(12, 3) NOT NULL,
    customer_id VARCHAR(20),
    country VARCHAR(100) NOT NULL
)