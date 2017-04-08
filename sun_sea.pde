import processing.sound.*;
FFT fft;             // Stores a Fourier transform of the sound signal
int NUM_BANDS = 256;
float baseLine;          // Position of the baseline.
float yoff = 0.0;
 
void setup()
{
  size(1000, 550);
  background(255,255,255);
  baseLine = 20;
  
  // Load the sound file.
  SoundFile song = new SoundFile(this, "I1 - (Kaytranada x Mr. Carmack).mp3");
  song.play();
 
  // Tell the Fast Fourier Transformer to process the song file.
  fft = new FFT(this, NUM_BANDS);
  fft.input(song);
  
}

void draw()
{
  fill(#17A4FA);
  beginShape(); 
 noStroke();
  float xoff = 10;        
  for (float x = 0; x <= width; x += 10) { 
    float y = map(noise(xoff, yoff), 0, 1, 400,250); 
    
    vertex(x, y); 
    // Increment x dimension for noise
    xoff += 0.05;
  }
  // increment y dimension for noise
  yoff += 0.01;
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
  
  
  // Draw a dark blue slightly transparent background
  noStroke();
  fill(135,234,254,18);
  rect(0,0,width,height);
   
  // Draw orange lines to represent volume
  stroke(255,33,8);
  strokeWeight(2);
  fill(255,90,13);
 
  fft.analyze();    // Analyse the current sound being played.
  translate(width/2, height/3.5);
  beginShape();
  for (int i=0; i<100; i=i+1)
  {
    float alpha = i *PI/100;
    float r = (sqrt(fft.spectrum[i])*190+60);
    vertex(cos(alpha)*r,sin(alpha)*r);
  }
  endShape();
  beginShape();
  for (int i=0; i<100; i=i+1)
  {
    float alpha = -i *PI/100;
    float r = (sqrt(fft.spectrum[i])*200+60);
    vertex(cos(alpha)*r,sin(alpha)*r+5);
  }
  endShape();
 
  // Move the baseline down the screen every frame unil it gets to bottom.
  baseLine++;
  if (baseLine > height-10)
  {
    baseLine = 20;
  }
   fill(3,219,255);
   
}