#homepass cycler script



Streetpass MAC Addresses pulled from:
https://docs.google.com/spreadsheet/ccc?key=0AvvH5W4E2lIwdEFCUkxrM085ZGp0UkZlenp6SkJablE#gid=0



crontab example:
*/3 * * * * cd /home/pi/dev/cyclepass && /home/pi/.rbenv/shims/ruby cycle.rb
