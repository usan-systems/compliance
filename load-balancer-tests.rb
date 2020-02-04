# Check that HTTP GET succeeds
describe command('curl https://1.15.1.31:9090/test/test.html') do
    its('exit_status') { should eq 0 }
end

# Check that HTTP GET succeeds
describe command('curl https://1.15.1.31:9091/test/test.html') do
    its('exit_status') { should eq 0 }
end

# Check that DNS is working
describe command('host google.com | egrep "google.com has address (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"') do
    its('exit_status') { should eq 0 }
end

# Check that rev_prox frontend is OPEN
describe command('echo "show stat" | socat stdio /run/haproxy/admin.sock | grep "apache_rev_prox_frontend,FRONTEND.*OPEN.*" ') do
    its('exit_status') { should eq 0 }
end

# Check that fwd_prox frontend is OPEN
describe command('echo "show stat" | socat stdio /run/haproxy/admin.sock | grep "apache_fwd_prox_frontend,FRONTEND.*OPEN.*" ') do
    its('exit_status') { should eq 0 }
end

# Check that rev_prox backend is UP
describe command('echo "show stat" | socat stdio /run/haproxy/admin.sock | grep "apache_rev_prox_nodes.*UP.*" ') do
    its('exit_status') { should eq 0 }
end

# Check that fwd_prox backend is UP
describe command('echo "show stat" | socat stdio /run/haproxy/admin.sock | grep "apache_fwd_prox_nodes.*UP.*" ') do
    its('exit_status') { should eq 0 }
end
