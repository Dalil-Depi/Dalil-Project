const paypal = require('paypal-rest-sdk');
const express = require('express');
const app = express();

paypal.configure({
  'mode': 'sandbox',
  'client_id': 'ASjs3uEkgEEU764ktH95ACVxgCGZzspsH_8zESQt82TkenLa7uN7gPTFwtfBUXIBT3HMGPKQyBmbt9Ai',
  'client_secret': 'EKf4ltjhuZ4M7SrqEYC5Ivb9XEc0ZMaUGu8kgCfZ13kABOqgtIGbHHhtQVVAb_Fk8faIViPozfDRxnm7'
});

app.get('/pay', (req, res) => {
  const amount = req.query.amount;
  if (!amount) return res.status(400).send("Amount is required");

  const create_payment_json = {
    "intent": "sale",
    "payer": { "payment_method": "paypal" },
    "redirect_urls": {
      "return_url": `https://f503-41-233-107-206.ngrok-free.app/success?amount=${amount}`,
      "cancel_url": "https://f503-41-233-107-206.ngrok-free.app/cancel"

    },
    "transactions": [{
      "item_list": {
        "items": [{
          "name": "Custom Payment",
          
          "sku": "custom",
          "price": amount,
          "currency": "USD",
          "quantity": 1
        }]
      },
      "amount": {
        "currency": "USD",
        "total": amount
      },
      "description": "Payment from Flutter App"
    }]
  };

  paypal.payment.create(create_payment_json, (error, payment) => {
    if (error) {
      console.error(error.response);
      return res.status(500).send("Payment creation failed",error);
    } else {
      const approvalUrl = payment.links.find(link => link.rel === 'approval_url');
      res.redirect(approvalUrl.href);
    }
  });
});

app.get('/success', (req, res) => {
  const payerId = req.query.PayerID;
  const paymentId = req.query.paymentId;
  const amount = req.query.amount;

  const execute_payment_json = {
    "payer_id": payerId,
    "transactions": [{
      "amount": {
        "currency": "USD",
        "total": amount
      }
    }]
  };

  paypal.payment.execute(paymentId, execute_payment_json, function (error, payment) {
    if (error) {
      console.error(error.response);
      throw error;
    } else {
      console.log("Get Payment Response"); 
      console.log("تم الدفع بنجاح");
    }
  });
});

app.listen(5000,() => {
  console.log("Server started");
});
