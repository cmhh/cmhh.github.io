window.onload = function() {
  const app = document.querySelector("#md");
  app.addEventListener('zero-md-rendered', async () => {
    const nav =  document.getElementById("nav");
    const root = app.shadowRoot;
    const sections = root.querySelectorAll("h1, h2");
    sections.forEach((section) => {
      const li = document.createElement("li");
      if (section.nodeName == "H1") li.classList.add("l1")
      const a = document.createElement("a");
      a.href = "#" + section.id;
      a.innerHTML = section.getInnerHTML();
      a.onclick = () => section.scrollIntoView({behavior: "smooth", block: "nearest"});
      li.append(a);
      nav.append(li);
    })
  });
}