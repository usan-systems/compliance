# InSpec regional proxy tests for WOR
proxy_ip = 192.168.32.12
proxy_port = 9091


# Check that HTTP GET succeeds
describe command('curl https://#{proxy_ip}:#{proxy_port}/test/test.html') do
    its('exit_status') { should eq 0 }
end

# Check that HTTP GET succeeds to Internet site allowed in proxy configuration
describe command('curl https://google.com/') do
    its('exit_status') { should eq 0 }
end

# Check that DNS is working
describe command('host google.com | egrep "google.com has address (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"') do
    its('exit_status') { should eq 0 }
end

# Check for no errors in Apache error log for mpm_prefork
describe command('grep "\[mpm_prefork:error\]" /var/log/apache2/error.log') do
    its('exit_status') { should eq 1 }
end

# Check for no errors in Apache error log for mpm_worker
describe command('grep "\[mpm_worker:error\]" /var/log/apache2/error.log') do
    its('exit_status') { should eq 1 }
end

# Check for no errors in fwd_prox_error_log:
describe command('egrep "\[.*:warn\].*|\[.*:error\].*" /var/log/apache2/fwd_prox_error_log') do
    its('exit_status') { should eq 1 }
end

# Check for no errors in rev_prox_error_log:
describe command('egrep "\[.*:warn\].*|\[.*:error\].*" /var/log/apache2/rev_prox_error_log') do
    its('exit_status') { should eq 1 }
end
