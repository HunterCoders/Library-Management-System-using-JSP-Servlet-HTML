package Fine;

public class Fine {
    public double calculateFine(int daysOverdue) {
        double fine = 0;

        if (daysOverdue <= 10) {
            fine = daysOverdue * 2; // Rs. 1 per day for the first 10 days
        } else if (daysOverdue <= 20) {
            fine = 10 + ((daysOverdue - 10) * 3); // Rs. 2 per day for the next 10 days
        } else {
            fine = 30 + ((daysOverdue - 20) * 5); // Rs. 3 per day after 20 days
        }

        return fine;
    }
}