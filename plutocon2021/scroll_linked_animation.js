

const bg = document.querySelector("#fancy-background")


const scrollwimages = bg.querySelectorAll("img.scrollw")
const rotateimages = bg.querySelectorAll("img.rotate")


const update = (fraction) => {
  scrollwimages.forEach(img => img.style.transform = `translateX(calc(${-fraction * 100}% + ${fraction * 100}vw))`)
  
  rotateimages.forEach(img => img.style.transform = `rotate(${fraction * 360}deg)`)
}


window.addEventListener('scroll', (e) => {
  
  const rect = document.body.getBoundingClientRect()
  
  const maxScrollTop = rect.height - window.innerHeight;
  const scrollFraction = -rect.y / maxScrollTop;
  
  update(scrollFraction)
})

update(0)