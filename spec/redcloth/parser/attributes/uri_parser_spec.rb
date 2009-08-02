require File.dirname(__FILE__) + "/../../../spec_helper"
require 'redcloth/parser/attributes/uri'

module RedCloth
  module Parser
    module Attributes
      describe Uri do
        before :each do
          @parser = UriParser.new
        end
  
        def parse(string)
          @parser.parse_or_fail(string)
        end
      
        it "should parse a simple URI" do
          parse("foo").should_not be_nil
        end
        
        schemes =  %w(ftp http https gopher mailto news nntp telnet wais file prospero)

        schemes.each do |scheme|
          it "should parse a URI with the #{scheme} scheme" do
            parse("#{scheme}://redcloth.org/").should_not be_nil
          end
        end
        
        it "should parse a mailto URI with email address" do
          parse("mailto:xxx@xxx.xxx.xxx").should_not be_nil
        end

        it "should parse a URI with a long path http://redcloth.org/foo/bar/baz" do
          parse("http://redcloth.org/foo/bar/baz").should_not be_nil
        end

        it "should parse a URI that lacks a trailing slash" do
          parse("http://redcloth.org").should_not be_nil
        end

        it "should parse localhost as the host" do
          parse("http://localhost").should_not be_nil
        end

        it "should parse an IP address as the host" do
          parse("http://192.168.1.1").should_not be_nil
        end

        it "should parse a relative URI with an absolute path" do
          parse("/foo/bar.html").should_not be_nil
        end

        it "should parse port numbers" do
          parse("http://localhost:3000").should_not be_nil
        end

        it "should parse a port number as low as 1" do
          parse("http://localhost:1").should_not be_nil
        end

        it "should parse a port number as high as 65536" do
          parse("http://localhost:65536").should_not be_nil
        end

        it "should parse a query string with a question mark and key-value pair" do
          parse("http://localhost:3000/foo?bar=baz").should_not be_nil
        end

        it "should parse a query string with multiple key-value pairs" do
          parse("http://localhost:3000/foo?bar=baz&foo=bar").should_not be_nil
        end

        it "should parse a query string with three key-value pairs" do
          parse("http://localhost:3000/foo?bar=baz&foo=bar&one=two").should_not be_nil
        end

        it "should parse a query string with multiple key-value pairs with numbers as values" do
          parse("http://localhost:3000/foo?bar=1&foo=2").should_not be_nil
        end
        
        it "should parse a fragment" do
          parse("#Examples_of_URI_references").should_not be_nil
        end
        
        it "should parse a relative path and fragment" do
          parse("URI#Examples_of_URI_references").should_not be_nil
        end
        
        it "should parse a lone hash" do
          parse("#").should_not be_nil
        end
        
        it "should parse a URI containing escapes" do
          parse("http://example.com/r?url=http%3A%2F%2Fwww.redcloth.org").should_not be_nil
        end
        
        it "should parse a complex relative path" do
          parse("../foo/./bar").should_not be_nil
        end
        
        it "should parse Ruby URI test 1" do
          parse("ftp://ftp.is.co.za/%2Frfc/rfc1808.txt").should_not be_nil
        end
        
        it "should parse Ruby URI test 2" do
          parse("gopher://spinaltap.micro.umn.edu/00/Weather/California/Los%20Angeles").should_not be_nil
        end
        
        it "should parse Ruby URI test 3" do
          parse("http://www.math.uio.no/faq/compression-faq/part1.html").should_not be_nil
        end

        it "should parse Ruby URI test 4" do
          parse("mailto:mduerst@ifi.unizh.ch").should_not be_nil
        end
        
        it "should parse Ruby URI test 5" do
          parse("news:comp.infosystems.www.servers.unix").should_not be_nil
        end
        
        it "should parse Ruby URI test 6" do
          parse("telnet://melvyl.ucop.edu/").should_not be_nil
        end
        
        it "should not parse Ruby URI test 7" do
          lambda { parse("http://a_b:80/") }.should raise_error
          lambda { parse("http://a_b/") }.should raise_error
        end
        
        it "should parse Ruby URI test 8" do
          parse("file:///foo/bar.txt").should_not be_nil
          parse("file:/foo/bar.txt").should_not be_nil
        end
        
        it "should parse Ruby URI test 9" do
          parse("ftp://:pass@localhost/").should_not be_nil
          parse("ftp://user@localhost/").should_not be_nil
          parse("ftp://localhost/").should_not be_nil
        end
        
        it "should parse IPv6 URI 1" do
          parse("http://[FEDC:BA98:7654:3210:FEDC:BA98:7654:3210]:80/index.html").should_not be_nil
        end
        it "should parse IPv6 URI 2" do
          parse("http://[1080:0:0:0:8:800:200C:417A]/index.html").should_not be_nil
        end
        it "should parse IPv6 URI 3" do
          parse("http://[3ffe:2a00:100:7031::1]").should_not be_nil
        end
        it "should parse IPv6 URI 4" do
          parse("http://[1080::8:800:200C:417A]/foo").should_not be_nil
        end
        it "should parse IPv6 URI 5" do
          parse("http://[::192.9.5.5]/ipng").should_not be_nil
        end
        it "should parse IPv6 URI 6" do
          parse("http://[::FFFF:129.144.52.38]:80/index.html").should_not be_nil
        end
        it "should parse IPv6 URI 7" do
          parse("http://[2010:836B:4179::836B:4179]").should_not be_nil
        end
        
      end
    end
  end
end