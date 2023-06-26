
from threading import Thread
import requests, re
from bs4 import BeautifulSoup


header =  {
    'Connection':'close',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36 Edg/113.0.1774.42'
}

def getPictrueID(pictrueID, page):

    print("正在获取第 %s 页的ID" %page)

    url = "https://wallhaven.cc/search?categories=110&purity=100&resolutions=1920x1080&topRange=1M&sorting=toplist&order=desc&ai_art_filter=1&page=" + str(page)
    
    req = requests.get(url=url, headers=header)

    soup = BeautifulSoup(req.text, 'html.parser')

    for tag in soup.find_all("a", class_="preview"):
        pictrueURL = re.findall('href="https://wallhaven.cc/w/(.*?)"', str(tag))
        pictrueID.append(pictrueURL[0])
    
    print(pictrueID)
    return pictrueID

def getPictrueHtml(pictrueHtml,  pictrueID):

    for i in range(len(pictrueID)):
        pic_url = 'https://wallhaven.cc/w/'+ pictrueID[i]

        try :
            req = requests.get(pic_url, headers=header,stream=True, verify=False)
            soup = BeautifulSoup(req.text, 'html.parser')
            items = soup.find_all('img')
            pictrueHtml.append(items[2].attrs['src'])
            print( "第" + str(i) + "张图片获取成功, 开始下载")

            t = Thread(target=download_pic, args=(items[2].attrs['src'], "C:\\Users\\lixingyang\\Desktop\\papers\\" + str(i) + ".png"))
            t.start()

        except:
            print("第" + str(i) + "张图片出现错误")

    return pictrueHtml

def printLinks(pictrueHtml):
    for i in range(len(pictrueHtml)):
        print(pictrueHtml[i])
    return

def download_pic(pic_url, pic_path):
    r  = requests.get(pic_url, headers=header)

    with open(pic_path, mode='wb') as f:
        f.write(r.content)
    
    print(pic_path, '下载完成')
    return

def main():
    pictrueHtml = []
    pictrueID = []

    for i in range(1, 6):
        getPictrueID(pictrueID, i)

    getPictrueHtml(pictrueHtml, pictrueID)

    return 






if __name__ == '__main__':
    main()
