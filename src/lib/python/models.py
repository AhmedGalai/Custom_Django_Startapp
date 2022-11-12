from django.contrib.auth.models import AbstractUser
from django.db import models
from datetime import datetime
# !!!!!!! image field requires pillow installation

class User(AbstractUser):
    id = models.AutoField(primary_key=True)

# Create your models here.

# class Product(models.Model):
#     id = models.AutoField(primary_key=True)
#     title = models.CharField(max_length=100, default=f"Musterprodukt")
#     category = models.CharField(max_length=50, default="Allgemein")
#     timestamp = models.DateTimeField(default=datetime.now, blank=True)
#     # price = models.IntegerField(blank = True, default=0)
#     description = models.TextField()
#     # image = models.ImageField(upload_to='default/images/', default='/../static/default/images/default_product.png')

#     def __str__(self):
#         return f"{self.title} [{self.id}]"

# class Subuser(models.Model):
#     user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="employee")
#     firstname = models.CharField(max_length=50, default="Mustervorname")
#     lastname = models.CharField(max_length=50, default=f"Musternachname")
#     # photo = models.ImageField(upload_to='default/images/', default='/../static/default/images/default_user.png')
#     # level = models.IntegerField(blank=True, default=0)
#     #following = models.ManyToManyField("self", blank=True)
#     timestamp = models.DateTimeField(default=datetime.now, blank=True)
#     # email = models.EmailField(blank=True)
#     # phone = models.CharField(max_length=20,default="Musternummer",blank=True)
#     def __str__(self):
#         return f"{self.firstname} {self.lastname} [{self.user.id}]"