import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["canvas", "ghost"]

  connect() {
    this.isDrawing = false
    this.ctx = this.canvasTarget.getContext("2d")
    this.ctx.lineWidth   = 4
    this.ctx.lineCap     = "round"
    this.ctx.lineJoin    = "round"
    this.ctx.strokeStyle = "#B91C1C"
  }

  startDraw(e) {
    this.isDrawing = true
    this.ctx.beginPath()
    this.ctx.moveTo(this.#pos(e).x, this.#pos(e).y)
  }

  draw(e) {
    if (!this.isDrawing) return
    this.ctx.lineTo(this.#pos(e).x, this.#pos(e).y)
    this.ctx.stroke()
  }

  stopDraw() {
    this.isDrawing = false
  }

  touchStart(e) {
    e.preventDefault()
    this.startDraw(e.touches[0])
  }

  touchMove(e) {
    e.preventDefault()
    if (!this.isDrawing) return
    this.ctx.lineTo(this.#pos(e.touches[0]).x, this.#pos(e.touches[0]).y)
    this.ctx.stroke()
  }

  clear() {
    const c = this.canvasTarget
    this.ctx.clearRect(0, 0, c.width, c.height)
  }

  setLetter(letter) {
    if (this.hasGhostTarget) this.ghostTarget.textContent = letter
    this.clear()
  }

  #pos(e) {
    const rect = this.canvasTarget.getBoundingClientRect()
    const c    = this.canvasTarget
    return {
      x: (e.clientX - rect.left) * (c.width  / rect.width),
      y: (e.clientY - rect.top)  * (c.height / rect.height)
    }
  }
}
