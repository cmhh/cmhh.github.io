window.onload = function() {
  const nav =  document.getElementById("nav");
  const navitems = document.querySelectorAll("#nav li > a");
  navitems.forEach((navitem) => {
    const section = document.getElementById(navitem.getAttribute("href").substring(1));
    navitem.onclick = (e) => {
      e.preventDefault();
      section.scrollIntoView({behavior: "smooth", block: "nearest"});
    }
  })
}