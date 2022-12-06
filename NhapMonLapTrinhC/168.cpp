#include <stdio.h>
#include <conio.h>
#include <math.h>

void kiemTraNhap(int &n)
{
	do
	{
		printf ("Nhap vao so luong phan tu mang phai lon hon 0: ");
		scanf ("%d", &n);
	}while(n < 0);
}
void nhapMang(int a[], int n)
{
	for (int i = 0; i < n; i++)
	{
		printf ("a[%d] = ", i);
		scanf ("%d", &a[i]);
	}
}

int soMu(int a[], int n)
{
	int mang = 0;
	for (int i = 0; i < n; i++)
	{
		if (pow(5, i) == a[i])
		{
			mang = 1;
			break;
		}
	}
	return mang;
}

int max(int a[], int n)
{
	int max = 0;
	for (int i = 0; i < n; i++)
	{
		if (a[i] > max && soMu(a, n) == 1)
			max = a[i];
	}
	return max;
}

int main()
{
	int a[100], n;
	kiemTraNhap(n);
	nhapMang(a, n);
	int k = max(a, n);
	if (k == 0)
		printf ("mang khong co so nao hop yeu cau");
	else
		printf ("so lon nhat trong mang va co dang 5 ^ k la: %d", k);
}


