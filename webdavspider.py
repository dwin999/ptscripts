#!/usr/bin/env python
#
# webdavspider 2016 dwin999
#
from creepy import Crawler
from urlparse import urlparse
import httplib
import argparse
parser = argparse.ArgumentParser(description='Spider and brute website for webdav enabled directories')
parser.add_argument('-u',action="store",dest="url", required=True, help='Target URL e.g http://127.0.0.1')
parser.add_argument('-d', action="store", dest="depth", default=5, type=int, help='Depth to crawl (default 5)')
args = parser.parse_args()

class DavCrawler(Crawler):
    dirz = []   
    def process_document(self, doc):
        if doc.status == 200:
            x = urlparse(doc.url)
        if x.path not in DavCrawler.dirz and "." not in x.path:
            dav_server = httplib.HTTPConnection(x.netloc)
            dav_server.request('PUT', x.path+"/file.txt", "webdav_test")
            dav_response = dav_server.getresponse()
            dav_server.close()
            if 200 <= dav_response.status < 300:
                    print str(dav_response.status) +" Uploaded to "+ x.netloc+x.path+"file.txt"
                    return
    def set_depth(self, max_depth):
         self.max_depth = max_depth
crawler = DavCrawler()
crawler.max_depth=args.depth
crawler.set_follow_mode(Crawler.F_SAME_HOST)
crawler.crawl(args.url)
