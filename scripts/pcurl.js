const path = require("path");
const fs = require("fs");

const puppeteer = require("puppeteer");

(async () => {
  const args = process.argv.slice(2);
  const urls = [];
  const viewport = {
    width: 1440,
    height: 1080,
    deviceScaleFactor: 1,
  };
  const launchOption = {
    headless: true,
  };
  let saveScreenshot = false;
  let ouputHtml = false;
  for (let i = 0; i < args.length; i++) {
    switch (args[i]) {
      case "--width":
        viewport.width = args[i + i];
        i++;
        continue;
      case "--height":
        viewport.height = args[i + i];
        i++;
        continue;
      case "--mobile":
        viewport.width = 320;
        viewport.height = 480;
        continue;
      case "--screenshot":
        saveScreenshot = true;
        continue;
      case "--no-headless":
        launchOption.headless = false;
        continue;
      case "--out":
        ouputHtml = true;
        continue;
      default:
        urls.push(args[i]);
        continue;
    }
  }

  const browser = await puppeteer.launch(launchOption);

  try {
    const page = await browser.newPage();
    await page.setViewport(viewport);

    page.on("console", (msg) => console.error("[CONSOLE]", msg.text()));
    page.on("requestfailed", (req) =>
      console.error("[FAILED]", req.url(), req.failure().errorText)
    );

    for (url of urls) {
      console.error("[URL]", url);

      await page.goto(url, { waitUntil: "networkidle2" });

      if (ouputHtml) {
        console.log(await page.evaluate(() => document.body.innerHTML));
      }

      if (saveScreenshot) {
        fs.mkdirSync(path.resolve("./" + url), { recursive: true });
        await page.screenshot({
          path: path.resolve("./" + url, "index.png"),
          fullPage: true,
        });
      }
    }
  } finally {
    await browser.close();
  }
})();
