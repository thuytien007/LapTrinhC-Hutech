#include <stdio.h>
#include <conio.h>

void kiemTraNhap(int &n)
{
	do
	{
		printf ("Nhap vao so luong phan tu mang phai lon hon 0: ");
		scanf ("%d", &n);
	}while(n < 0);
}
void nhapMang(float a[], int n)
{
	for (int i = 0; i < n; i++)
	{
		printf ("a[%d] = ", i);
		scanf ("%f", &a[i]);
	}
}
float soDuongDT(float a[], int n)
{
	float k = -1;
	for (int i = 0; i < n; i++)
	{
		if (a[i] > 0)
		{
			k = a[i];
			break;	
		}
	}
	return k;
}
float Min(float a[], int n)
{
	float min = soDuongDT(a, n);
	if (min == -1)
		return -1;
	else
	{
		float vitri = 0;
		for (int i = 1; i < n; i++)
		{
			if (a[i] <= min && a[i] > 0)
			{
				min = a[i];
				vitri = i;
			}
		}
		return vitri;
	}
}
int main ()
{
	float a[100];
	int n;
	kiemTraNhap(n);
	nhapMang(a, n);
	float t = Min(a, n);
	if (t == -1)
		printf ("mang khong co so duong nao");
	else
		printf ("Vi tri so duong nho nhat trong mang la: %.1f", t);
	return 0;
}
