
double calculateCargoCharges({ required double ticketPrice, required double weight }){
 return (0.2 + (500 * weight)); // (20% of price + (weight. * 500))
}