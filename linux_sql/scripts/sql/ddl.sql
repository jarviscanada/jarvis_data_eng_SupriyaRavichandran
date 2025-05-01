DELETE FROM host_usage;
DELETE FROM host_info;
-- Only insert if data doesn't already exist
INSERT INTO host_info (hostname, cpu_number, cpu_architecture, cpu_model, cpu_mhz, l2_cache, timestamp, total_mem)
SELECT 'noe1', 1, 'x86_64', 'Intel(R) Xeon(R) CPU @ 2.30GHz', 2300, 256, '2019-05-29 17:49:53.000', 601324
WHERE NOT EXISTS (SELECT 1 FROM host_info WHERE hostname = 'noe1');

INSERT INTO host_info (hostname, cpu_number, cpu_architecture, cpu_model, cpu_mhz, l2_cache, timestamp, total_mem)
SELECT 'noe2', 1, 'x86_64', 'Intel(R) Xeon(R) CPU @ 2.30GHz', 2300, 256, '2019-05-29 17:49:53.000', 601324
WHERE NOT EXISTS (SELECT 1 FROM host_info WHERE hostname = 'noe2');
INSERT INTO host_usage (timestamp, host_id, memory_free, cpu_idle, cpu_kernel, disk_io, disk_available)
VALUES
('2019-05-29 15:00:00.000', (SELECT id FROM host_info WHERE hostname = 'noe1'), 300000, 90, 4, 2, 31220),
('2019-05-29 15:01:00.000', (SELECT id FROM host_info WHERE hostname = 'noe2'), 200000, 90, 4, 2, 31220);

SELECT * FROM host_info;
SELECT * FROM host_usage;
