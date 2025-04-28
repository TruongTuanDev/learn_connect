#include <iostream>
#include <string>
using namespace std;

int n; 
int x[100]; 
string indent = ""; 

// Ham xuat ket qua
void Binary_result() {
    for (int i = 1; i <= n; i++) {
        cout << x[i];
    }
    cout << endl;
}


void Try(int i) {
    for (int j = 0; j <= 1; j++) {
        x[i] = j;
        cout << indent << "Try(" << i << "): j = " << j << "; x" << i << " = " << j;
        
        if (i == n) {
            cout << "; i = n = " << n << " nen xuat ";
            Binary_result();
        } else {
            cout << "; i = " << i << " < n = " << n << " nen goi Try(" << i + 1 << ")" << endl;
            indent += "  "; 
            Try(i + 1);
            indent = indent.substr(0, indent.length() - 2); 
        }
        
        if (j == 1) {
            cout << indent << "Try(" << i << "): j = " << j + 1 << " > 1 nen thoat khoi Try(" << i << ") va quay lui" << endl;
        }
    }
}

int main() {
    cout << "Nhap do dai n cua day nhi phan: ";
    cin >> n;
    cout << "Khi n = " << n << ", cay tim kiem quay lui nhu sau:" << endl;
    Try(1);
    return 0;
}