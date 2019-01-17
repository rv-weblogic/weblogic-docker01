nmConnect('{{ weblogic_admin_user }}', '{{ weblogic_admin_password }}', '172.17.0.2', '{{ unique_id + 20000|int }}', '{{ weblogic_domain_name }}')
nmStart('{{ weblogic_domain_name }}Admin')
