# Vuln-Lab-Setup

A curated collection of vulnerable applications and labs available via **Docker** and **Git**, designed for penetration testing, bug bounty practice, and security learning.

> Maintained by [@sachinn403](https://github.com/sachinn403) 🛡️

---

## 🐳 Why Docker?

Most labs in this repository run inside **Docker containers**, making setup, isolation, and cleanup easy and consistent across systems. This allows you to:

- ✅ Avoid system conflicts
- 🚀 Launch environments instantly
- ♻️ Reset broken labs with a single command
- 🔐 Contain insecure apps safely on your local machine

If you're new to Docker, [check out the docs here](https://docs.docker.com/get-docker/) to get started.

---

## 🧠 Dashboard Script Usage

This repository includes a dashboard script (`dashboard.sh`) that simplifies management of all vulnerable labs:

* ✅ Install All or Selected Labs
* ▶️ Start Selected Apps
* 👁️ View Currently Running Apps
* ⛔ Stop One, Multiple, or All Running Apps

### Launch Dashboard

```bash
chmod +x dashboard.sh
sudo ./dashboard.sh
```

---

✅ **Tip:** Use the `dashboard.sh` script to install, launch, and manage these labs from a centralized interface.

🧐 **Pro Tip:** Prioritize labs that align with your focus (e.g., API testing, CVEs, mobile apps, CTFs).

---

## 🧩 Contributing

Found a new lab or have an improvement? Feel free to [open an issue](https://github.com/sachinn403/Vuln-Lab-Setup/issues) or submit a pull request to enhance the collection.

---

⭐ **If this repo helps your pentesting journey, please consider giving it a star!**  
Maintained by [@sachinn403](https://github.com/sachinn403) 🛡️

Happy hacking! 🧑‍💻

---


## 📦 Vulnerable Labs List

A curated collection of intentionally vulnerable applications for learning, practicing, and mastering web application security, bug bounty hunting, and secure coding techniques. Most labs can be run via Docker or cloned from GitHub.

| No. | Name                              | Type       | Description / Source                                                                                            |
| --- | --------------------------------- | ---------- | --------------------------------------------------------------------------------------------------------------- |
| 1   | **DVWA**                          | Docker     | Damn Vulnerable Web App — classic web vulnerabilities in PHP (`sagikazarmark/dvwa`)                             |
| 2   | **Juice Shop**                    | Docker     | OWASP modern insecure web app (`bkimminich/juice-shop`)                                                         |
| 3   | **VulnerableApp**                 | Git        | Java-based lab with multiple vulnerability scenarios ([GitHub](https://github.com/SasanLabs/VulnerableApp.git)) |
| 4   | **WebGoat**                       | Docker     | OWASP app for Java security training (`webgoat/webgoat`)                                                        |
| 5   | **WebGoat 7.1**                   | Docker     | Legacy version of WebGoat (`webgoat/webgoat:7.1`)                                                               |
| 6   | **SQLi-Labs**                     | Docker     | Labs focused on mastering SQL Injection (`acgpiano/sqli-labs`)                                                  |
| 7   | **bWAPP**                         | Docker     | Buggy Web App with 100+ security issues (`raesene/bwapp`)                                                       |
| 8   | **Mutillidae**                    | Git        | OWASP-focused PHP/MySQL app ([GitHub](https://github.com/webpwnized/mutillidae-docker.git))                     |
| 9   | **DVGA**                          | Docker     | Android-based insecure web app (`dolevf/dvga`)                                                                  |
| 10  | **RESTurant API**                 | Git        | Vulnerable RESTful API game ([GitHub](https://github.com/theowni/Damn-Vulnerable-RESTaurant-API-Game.git))      |
| 11  | **Pixi**                          | Git        | Microservices-based insecure app for AppSec ([GitHub](https://github.com/DevSlop/Pixi.git))                     |
| 12  | **PyGoat**                        | Docker     | Python Flask app with OWASP Top 10 flaws (`pygoat/pygoat:latest`)                                               |
| 13  | **SSRF Lab**                      | Docker     | Test Server-Side Request Forgery (`youyouorz/ssrf-vulnerable-lab`)                                              |
| 14  | **VulnBank**                      | Git        | Simulated vulnerable banking system ([GitHub](https://github.com/Commando-X/vuln-bank.git))                     |
| 15  | **VulnLab**                       | Docker     | General purpose vulnerable lab (`yavuzlar/vulnlab`)                                                             |
| 16  | **WrongSecrets**                  | Docker     | App to learn poor secrets management (`jeroenwillemsen/wrongsecrets:latest-no-vault`)                           |
| 17  | **Yrprey**                        | Git        | Modern, intentionally insecure application ([GitHub](https://github.com/yrprey/yrprey-application.git))         |
| 18  | **Zero Health**                   | Git        | Health-based insecure platform ([GitHub](https://github.com/aligorithm/zero-health.git))                        |
| 19  | **Vulnerable WordPress**          | Docker     | WP with vulnerable plugins/themes (`wpscanteam/vulnerablewordpress`)                                            |
| 20  | **Security Ninjas**               | Docker     | Security training dojo (`opendns/security-ninjas`)                                                              |
| 21  | **Altoro Mutual**                 | Docker     | Legacy vulnerable banking app (`hclproducts/altoroj`)                                                           |
| 22  | **Vulnerable GraphQL API**        | Docker     | Insecure GraphQL interface (`carvesystems/vulnerable-graphql-api`)                                              |
| 23  | **BodgeIt Store**                 | Docker     | Java e-commerce site with vulnerabilities (`psiinon/bodgeit`)                                                   |
| 24  | **crAPI**                         | Git        | Insecure API simulating smart vehicle access ([GitHub](https://github.com/OWASP/crAPI.git))                     |
| 25  | **VAmPI**                         | Docker     | Vulnerable API built in Flask (`erev0s/vampi`)                                                                  |
| 26  | **NodeGoat**                      | Docker     | Node.js app with OWASP Top 10 (`owasp/nodegoat`)                                                                |
| 27  | **Security Shepherd**             | Docker     | Gamified security training platform (`owasp/securityshepherd`)                                                  |
| 28  | **UnSAFE Bank**                   | Docker     | Android-focused insecure app (`lucideus/unsafe_bank`)                                                           |
| 29  | **OWASP VulnerableApp Facade**    | Docker     | Single UI for multiple OWASP labs (`sasanlabs/owasp-vulnerableapp-facade`)                                      |
| 30  | **Vulnado**                       | Docker     | Node.js app with CVE flaws (`scalesec/vulnado`)                                                                 |
| 31  | **DVIA**                          | Docker     | Damn Vulnerable iOS App (`appsecco/dvia`)                                                                       |
| 32  | **Damn Vulnerable C# App**        | Docker     | .NET app with security holes (`abhaybhargav/dvcsharp`)                                                          |
| 33  | **Template Injection Playground** | Docker     | Learn Server-Side Template Injection (`james9909/template-injection-playground`)                                |
| 34  | **Wayfarer**                      | Docker     | Travel booking site with OWASP bugs (`stratussecurity/wayfarer`)                                                |
| 35  | **Hackazon**                      | Docker     | Simulated insecure e-commerce store (`opportunisticsecurity/hackazon`)                                          |
| 36  | **RailsGoat**                     | Docker     | Ruby on Rails vulnerable app (`owasp/railsgoat`)                                                                |
| 37  | **Defectdojo**                    | Git        | Vulnerability management system ([GitHub](https://github.com/DefectDojo/django-DefectDojo))                     |
| 38  | **Vulhub**                        | Git/Docker | Large collection of CVE-based vulnerable environments ([GitHub](https://github.com/vulhub/vulhub))              |
| 39  | **Juice Shop CTF**                | Docker     | CTF variant of Juice Shop (`bkimminich/juice-shop-ctf`)                                                         |
| 40  | **DSVW**                          | Docker     | Single-page vulnerable app (`infosecdojo/dsvw`)                                                                 |
| 41  | **AppSec Lab**                    | Git        | OWASP-styled training setup ([GitHub](https://github.com/SecurityBreachIO/AppSec-Lab))                          |
| 42  | **Vulnerable Flask App**          | Git        | Flask-based training app ([GitHub](https://github.com/Brum3ns/Vulnerable-Flask-App))                            |
| 43  | **Vulnerable PHP App**            | Docker     | PHP 8.1 version of DVWA (`vulnerables/web-dvwa:php8.1`)                                                         |
| 44  | **phpBB CVE-2020-8229**           | Git        | phpBB with known RCE vuln ([GitHub](https://github.com/vulhub/phpbb-CVE-2020-8229))                             |
| 45  | **Jenkins CVE-2017-1000353**      | Git        | Jenkins with serialized RCE bug ([GitHub](https://github.com/vulhub/jenkins-CVE-2017-1000353))                  |
| 46  | **Node.js CMS SQLi Lab**          | Git        | Node CMS with SQLi ([GitHub](https://github.com/vulhub/node-cms-sqli-lab))                                      |
| 47  | **Mongo Express Vulnerable**      | Docker     | MongoDB admin tool with flaws (`vulnerables/mongo-express`)                                                     |
| 48  | **Magento CVE-2015-1397**         | Git        | Magento CVE demo ([GitHub](https://github.com/vulhub/magento-CVE-2015-1397))                                    |
| 49  | **Joomscan Target**               | Docker+Git | Joomla vuln scanner & demo ([GitHub](https://github.com/OWASP/joomscan))                                        |
| 50  | **DVNA**                          | Docker     | Damn Vulnerable Node App (`appsecco/dvna`)                                                                      |



